set fish_greeting
set fish_cursor_default line
set fish_cursor_insert line
set fish_cursor_visual block
set fish_cursor_replace underscore
set -gx EDITOR nvim
set -gx VISUAL nvimet fish_vi_force_cursor 1

# Aliases can stay outside
# Use fish_config for interactive fish configuration
alias ma='/users/teekm/dev/2025/go/mindarc-aws/build/mindarcaws-darwin-amd64'
alias ks=k9s
alias q=exit
alias v='nvim'
alias c='clear'
alias gg='lazygit'
alias n='cd /Users/teekm/Dev/2025/vim; nvim'
alias cd='z'
alias ka='pkill -f AeroSpace'

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function awsupdate
    set -l myip (dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '"')
    set -l timestamp (date '+%Y-%m-%d %H:%M:%S')
    aws ec2 modify-security-group-rules --group-id sg-0053cf18fac32bdbb --security-group-rules "SecurityGroupRuleId=sgr-0f36539805d442cb3,SecurityGroupRule={IpProtocol=tcp,FromPort=22,ToPort=22,CidrIpv4=$myip/32,Description='Tom Kim, updated at $timestamp'}"
end

function repo
    git remote -v | grep origin | head -1 | grep -o "github.com[:/][^ ]*" | sed "s/.*github.com[\/\:]//" | xargs -I {} open https://github.com/{}
end

# Interactive-only stuff
if status is-interactive
    fish_vi_key_bindings
    # Key bindings
    function fish_user_key_bindings
        bind \cr 'history | fzf | read -l result; and commandline $result'
    end

    # Shell integrations
    if string match -q -- 'tmux*' $TERM
        set -g fish_vi_force_cursor 1
    end

    atuin init fish --disable-up-arrow | source
    zoxide init fish | source
    starship init fish | source
end

pyenv init - fish | source
