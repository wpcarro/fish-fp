# When the Emacs SSH client, Tramp, connects to a remote host that uses Fish,
# it's important to keep the shell prompt simple so that Tramp can parse it.
if test "$TERM" = "dumb"
    function fish_prompt
        echo "\$ "
    end
    function fish_right_prompt; end
    function fish_greeting; end
    function fish_title; end
else
    function fish_prompt
        # Cache status before we overwrite it.
        set -l last_status $status

        # Colors
        set -l color_inactive (set_color red --bold)
        set -l color_active (set_color green --bold)
        set -l color_normal (set_color normal)

        # SSH information
        if set -q SSH_CLIENT; or set -q SSH_TTY
            echo -en "$color_active \bssh ✓ [$color_normal$USER@"(hostname)"$color_active]$color_normal"
        else
            echo -en "$color_inactive \bssh ✗ [$color_normal$USER@"(hostname)"$color_inactive]$color_normal"
        end

        # Separator
        echo -n " "

        # Git information
        set -l git_repo (git rev-parse --show-toplevel 2>/dev/null)
        set -l git_status $status

        if [ (realpath .) = "/" ]
            set -g dir_path (realpath .)
        else if [ (realpath ..) = "/" ]
            set -g dir_path (realpath .)
        else
            set -g dir_path (echo (basename (realpath ..))"/"(basename (realpath .)))
        end

        if test $git_status -eq 0
            set -l git_repo_name (basename (git rev-parse --show-toplevel))
            set -l git_branch (git branch 2>/dev/null | grep '^\*' | cut -d' ' -f2-)
            echo -en "$color_active \bgit ✓ [$color_normal$git_branch$color_active|$color_normal$git_repo_name$color_active|$color_normal$dir_path$color_active]$color_normal"
        else
            echo -en "$color_inactive \bgit ✗ [$color_normal$dir_path$color_inactive]$color_normal"
        end

        # Newline
        echo

        # Handle root vs non-root
        if [ "$USER" = "root" ]
            set -g prompt_sigil "#"
        else
            set -g prompt_sigil "λ"
        end

        set -l time (date +"%T")
        if test $last_status -eq 0
            set -l color_prompt (set_color white --bold)
            echo -n "$time$color_prompt $prompt_sigil$color_normal "
        else
            set -l color_prompt (set_color red --bold)
            echo -n "$time$color_prompt $prompt_sigil$color_normal "
        end
    end
    function fish_right_prompt; end
    function fish_greeting; end
    function fish_title; end
end
