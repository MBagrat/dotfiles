# Git sign commit and tag

### Print gpg secret keys

```shell
gpg --list-secret-keys --keyid-format=long
```

### Export gpg key to put on github, gitlab, etc...

```shell
gpg --armor --export {gpg key i}
```

### Git config singin key

```shell
git config --global user.signingkey {gpg secret key id}
```

### Git set gpg program

```shell
git config --global gpg.program /opt/homebrew/bin/gpg 
```

### Git enable commit sign
```shell
git config --global commit.gpgSign true
```

### Git enable tag sign
```shell
git config --global tag.gpgSign true
```
