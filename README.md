# wsl2-ssh-pageant
Oh My Zsh custom plugin for wsl2-ssh-pageant

Enables [wsl2-ssh-pageant](https://github.com/BlackReloaded/wsl2-ssh-pageant) to replace 
[GPG's gpg-agent](https://www.gnupg.org/documentation/manuals/gnupg/) when running under
WSL2.

If `enable-ssh-support` is configured in the `gpg-agent.conf` then it will enable the
`SSH_AUTH_SOCK` as well.

To install, clone the repositry to the Oh My Zsh custom plugins directory:
```zsh
git clone --depth=1 https://github.com/jbouse/wsl2-ssh-pageant.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/wsl2-ssh-pageant
```
    
To use it, add `wsl2-ssh-pageant` to the plugins array of your zshrc file:

```zsh
plugins=(... wsl2-ssh-pageant)
```
