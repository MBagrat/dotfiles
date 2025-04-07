# Taps
tap '1password/tap'
tap 'buildpacks/tap'
tap 'graalvm/tap'
tap 'homebrew/autoupdate'
tap 'homebrew/bundle'
tap 'homebrew/services'
tap 'hashicorp/tap'
tap 'maciejwalkowiak/brew'
tap 'mdogan/zulu'
tap 'spring-io/tap'
tap 'atomicjar/tap'
tap 'ubuntu/microk8s'
tap 'netbirdio/tap'
tap 'shaunsingh/SFMono-Nerd-Font-Ligaturized'

# Architecture Detection
# uname -m returns the architecture of the system.
# - For ARM-based Macs, this returns "arm64".
# - For Intel-based Macs, it returns "x86_64".
arch = `uname -m`.chomp

# Essential System Tools
brew 'coreutils'
brew 'gawk'
brew 'gsed'
brew 'curl'
brew 'wget'
brew 'bash'
brew 'bc'
brew 'trash-cli'
brew 'tree'
brew 'pinentry-mac'
brew 'openssl@3'
brew 'readline'

# Package Managers
brew 'mas'
brew 'yarn'

# Development Environment Management
brew 'anyenv'
brew 'cocoapods'
cask 'wakatime'

# Security & Encryption
brew 'gnupg'

# Development Tools & Version Control
brew 'git'
brew 'lazygit'
brew 'neovim'
brew 'tmux'
brew 'tpm'
brew 'starship'
brew 'stow'
brew 'chezmoi'
brew 'mackup'

# Search and Navigation Tools
brew 'fzf'
brew 'ripgrep'
brew 'fd'
brew 'zoxide'
brew 'eza'
brew 'bat'
brew 'fx'
brew 'jq'
brew 'yh'

# System Monitoring & Performance
brew 'htop'
brew 'btop'
brew 'ctop'
brew 'speedtest-cli'

# Languages and Runtimes
brew 'go'
brew 'rust'
brew 'kotlin'
brew 'julia'
brew 'php'
brew 'composer'
brew 'black'
brew 'prettier'
brew 'luarocks'

# Build Tools & Package Managers
brew 'cmake'
brew 'gradle'
brew 'maven'
brew 'just'
brew 'pack'

# Container and Cloud Tools
brew 'kubernetes-cli'
brew 'helm'
brew 'terraform'
brew 'k9s'
brew 'kind'
brew 'minikube'
brew 'microk8s'
brew 'podman'
brew 'netbird'
brew 'ansible'
brew 'dive'
brew 'kdoctor'

# Virtualization & Emulation
brew 'qemu'

# Development Libraries
brew 'libyaml'
brew 'libssh2'
brew 'libavif'
brew 'gd'
brew 'libheif'
brew 'libpq'
brew 'poppler'
brew 'gmp'

# Development Tools
brew 'spring-boot'
brew 'jhipster'
brew 'jmeter'
brew 'graphviz'
brew 'groovy'
brew 'httpie'
brew 'tealdeer'
brew 'telnet'

# Media & Entertainment
brew 'cmus'
brew 'nowplaying-cli'
brew 'pngpaste'

# CLI Helpers & Utils
brew 'tlrc'
brew 'thefuck'

# Applications
## Productivity & Utilities
cask '1password'
cask '1password-cli'
cask 'adguard'
cask 'alfred'
cask 'appcleaner'
cask 'keyboardcleantool'
cask 'daisydisk'
cask 'hiddenbar'
cask 'rectangle'
cask 'pearcleaner'
cask 'keka'
cask 'itermai'
cask 'msty'
cask 'vanilla'
cask 'browserosaurus'
cask 'brewservicesmenubar'
cask 'thingsmacsandboxhelper'

## Browsers
cask 'arc'
cask 'firefox'
cask 'google-chrome'
cask 'zen-browser' if arch == 'x86_64'

## Terminal Emulators
cask 'iterm2'
if arch == 'x86_64'
  cask 'alacritty'
  cask 'kitty'
  cask 'warp'
end

## Development Tools & IDEs
cask 'visual-studio-code'
cask 'zed'
cask 'drawio'
cask 'keystore-explorer'
cask 'flutter'
if arch == 'x86_64'
  cask 'sublime-text'
  cask 'dbeaver-community'
  cask 'gitbutler'
end
cask 'fork'
cask 'tower'
cask 'lens'
cask 'mongodb-compass'
cask 'pgadmin4'
cask 'postman'
cask 'mockoon'
cask 'proxyman'
if arch == 'x86_64'
  cask 'redis-insight'
  cask 'podman-desktop'
  cask 'wave'
  cask 'windsurf'
end

## Virtualization & Containers
cask 'docker'
cask 'testcontainers-desktop'
cask 'utm'
if arch == 'x86_64'
  cask 'orbstack'
  cask 'multipass'
end

## Communication & Messaging
cask 'slack'
cask 'telegram'
cask 'zoom'
if arch == 'x86_64'
  cask 'discord'
  cask 'messenger'
  cask 'signal'
  cask 'viber'
  cask 'wechat'
  cask 'whatsapp'
end

## Media & Entertainment
cask 'spotify'
cask 'vlc'
cask 'folx'
cask 'fliqlo'
cask 'yandex-music' if arch == 'x86_64'

## Productivity & Note-taking
cask 'notion'
cask 'notion-calendar'
cask 'obsidian'
cask 'todoist'
cask 'netnewswire'
cask 'google-drive' if arch == 'x86_64'

## Remote & Collaboration
if arch == 'x86_64'
  cask 'anydesk'
  cask 'netbird-ui'
  cask 'openvpn-connect'
end
cask 'microsoft-remote-desktop' if arch == 'arm64'

## AI & Development
cask 'ollama'
if arch == 'arm64'
  cask 'chatgpt'
  cask 'lm-studio'
end

## Screen Recording & Streaming
if arch == 'x86_64'
  cask 'keycastr'
  cask 'obs'
end
cask 'flameshot' if arch == 'arm64'

# Quick Look Plugins
cask 'qlcolorcode'
cask 'qlimagesize'
cask 'qlmarkdown'
cask 'qlstephen'
cask 'qlvideo'
cask 'quicklook-json'
cask 'quicklookase'
cask 'qlprettypatch'
cask 'quicklook-csv'
cask 'qlplayground'
cask 'webpquicklook'

# Fonts
cask 'font-fira-code'
cask 'font-fira-code-nerd-font'
cask 'font-fira-mono'
cask 'font-fira-mono-for-powerline'
cask 'font-jetbrains-mono'
cask 'font-jetbrains-mono-nerd-font'
cask 'font-meslo-lg'
cask 'font-meslo-lg-dz'
cask 'font-meslo-lg-nerd-font'
cask 'font-sf-mono-nerd-font-ligaturized'

# Java Development
## Amazon Corretto (Alternative Distribution)
cask 'corretto@8'
cask 'corretto@11'
cask 'corretto@17'
cask 'corretto@21'

## Java IDEs
cask 'jetbrains-toolbox'
cask 'springtoolsuite'
cask 'netbeans'

## Java Tools
cask 'visualvm' # Add this line

# Alternative JDK distributions (commented)

# Java Development
## OpenJDK (Official)
# brew 'openjdk@8' if arch == 'x86_64'
# brew 'openjdk@11'
# brew 'openjdk@17'
# brew 'openjdk@21'
# brew 'openjdk'

### Eclipse Temurin releases
# cask 'temurin@8'
# cask 'temurin@11'
# cask 'temurin@17'
# cask 'temurin@21'
# cask 'temurin'

### GraalVM CE releases
# cask 'graalvm-community-jdk17'
# cask 'graalvm-community-jdk21'
# cask 'graalvm-community-jdk22'

### Zulu JDK releases
# cask 'zulu-jdk8'
# cask 'zulu-jdk11'
# cask 'zulu-jdk17'
# cask 'zulu-jdk21'
# cask 'zulu'

# Mac App Store Applications
## Productivity
mas 'Things', id: 904_280_696
mas 'Amphetamine', id: 937_984_704
mas 'Dato', id: 1_470_584_107
mas 'Dropover - Easier Drag & Drop', id: 1_355_679_052
mas 'Magnet', id: 441_258_766
mas 'pomodorome', id: 1_484_801_884

## Apple Apps
mas 'Keynote', id: 409_183_694
mas 'Numbers', id: 409_203_825
mas 'Pages', id: 409_201_541
mas 'Xcode', id: 497_799_835

## Utilities
mas '1Password for Safari', id: 1_569_813_296
mas 'Battery Health 2', id: 1_120_214_373
mas 'CleanMyDrive 2', id: 523_620_159
mas 'Color Picker', id: 1_545_870_783
mas 'Hand Mirror', id: 1_502_839_586
mas 'Startup Disk Full Fixer', id: 1_346_655_838
mas 'WaterMinder', id: 1_415_257_369

## Communication
mas 'Spark', id: 1_176_895_641

## Media & Design
mas 'Unsplash Wallpapers', id: 1_284_863_847
if arch == 'x86_64'
  mas 'Pixea', id: 1_507_782_672
  mas 'ScreenBrush', id: 1_233_965_871
end
