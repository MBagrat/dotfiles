# kitty — suggestions

Config: `stow/kitty/.config/kitty/` (kitty 0.47.4)

## 1. `tab_bar.py` runs `pmset` in the render path (performance bug)

`draw_tab()` calls `get_battery_cells()` unconditionally, and `draw_tab` runs
**for every tab on every redraw**. On top of that, a 1-second repeating timer
forces a redraw. Net effect: with 3 tabs open, kitty forks a `pmset`
subprocess (blocking, up to the 1 s timeout) three times per second — to
display a value that changes maybe once a minute.

Cache the battery cells and refresh them on their own slow cadence; keep only
the clock on the fast timer:

```python
BATTERY_REFRESH_TIME = 30
_battery_cells: list = []

def _update_battery(_=None):
    global _battery_cells
    _battery_cells = get_battery_cells()
    _redraw_tab_bar(None)

def draw_tab(...):
    global timer_id
    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME, True)
        add_timer(_update_battery, BATTERY_REFRESH_TIME, True)
        _update_battery()
    ...
    cells = list(_battery_cells)
    cells.append((clock_color, clock))
    ...
```

Bonus: since the clock only shows `%H:%M`, even the 1 s redraw timer is 60×
more frequent than needed — but it's cheap once `pmset` is out of the loop,
so fixing the subprocess is the part that matters.

## 2. `charged` battery state uses the wrong color table (minor bug)

In `get_battery_cells()`, the `charged` branch picks `icon_color` from
`UNPLUGGED_COLORS`, so a fully charged plugged-in battery renders white
(`color15`) — while `PLUGGED_COLORS` deliberately maps `100 → green`. The
branch also then duplicates the `PLUGGED_ICONS` lookup. Resolving the
in-code `TODO` fixes both at once:

```python
def _closest(table, percent):
    return table[min(table, key=lambda k: abs(k - percent))]

if status == "discharging":
    icon_color = _closest(UNPLUGGED_COLORS, percent)
    icon = _closest(UNPLUGGED_ICONS, percent)
else:  # charging / charged / AC
    icon_color = _closest(PLUGGED_COLORS, percent)
    icon = _closest(PLUGGED_ICONS, percent)
```

## 3. `tab_title_template`: `title.rindex(title[-1]) + 1` is just `len(title)`

The last character's last occurrence is always at index `len(title) - 1`, so
the expression is a roundabout `len(title)` — and it raises `IndexError` on an
empty title, making kitty fall back to the default template. Same behavior,
readable, and safe on empty strings:

```
tab_title_template "{f'{title[:30]}…' if len(title) > 30 else (title.center(6) if len(title) % 2 == 0 else title.center(5))}"
```

## 4. Battery/clock duplication with the tmux status bar

The kitty tab bar (bottom) and the tokyo-night tmux bar (top) both show
battery + date + time. Given tmux is effectively always running, consider
letting one bar own the "system status" job — see [tmux.md](tmux.md) #7. If
the tmux bar wins, `tab_bar.py` shrinks to just the icon + tabs and issues #1
and #2 disappear entirely.

## 5. Small `kitty.conf` hygiene (optional)

```conf
# No audible bell (tab_activity/bell already disabled for tabs)
enable_audio_bell no

# Don't prompt on close when only the shell is running; tmux sessions are
# resurrect-backed anyway. Use 'count' behavior if you prefer a guard:
confirm_os_window_close 0
```

Also: the four explicit `bold_font`/`italic_font`/`bold_italic_font` lines can
collapse to `font_family family="JetBrainsMono Nerd Font Mono"` with kitty's
newer font selection syntax (`bold_font auto` etc.), but the current explicit
form works fine — only worth touching if you ever switch fonts.
