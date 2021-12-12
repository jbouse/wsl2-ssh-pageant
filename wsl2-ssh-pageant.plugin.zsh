export GPG_TTY=$TTY

wsl2_ssh_pageant_bin="$HOME/.ssh/wsl2-ssh-pageant.exe"

function _gpg-agent_kill {
    gpgconf --kill gpg-agent 2>/dev/null
}
autoload -U add-zsh-hook
add-zsh-hook preexec _gpg-agent_kill

export GPG_AGENT_SOCK="$(gpgconf --list-dirs agent-socket)"
if ! ss -a | grep -q "$GPG_AGENT_SOCK "; then
    rm -f "$GPG_AGENT_SOCK"
    if test -x "$wsl2_ssh_pageant_bin"; then
        (setsid nohup socat UNIX-LISTEN:"$GPG_AGENT_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin --gpg S.gpg-agent" >/dev/null 2>&1 &)
    else
        echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
    fi
fi

if [[ $(gpgconf --list-options gpg-agent | awk -F: '$1=="enable-ssh-support" {print $10}') = 1 ]]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    if ! ss -a | grep -q "$SSH_AUTH_SOCK "; then
        rm -f "$SSH_AUTH_SOCK"
        if test -x "$wsl2_ssh_pageant_bin"; then
            (setsid nohup socat UNIX-LISTEN:"$SSH_AUTH_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin" >/dev/null 2>&1 &)
        else
            echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
        fi
    fi
fi

unset wsl2_ssh_pageant_bin
unfunction _gpg-agent_kill
