# # don't put duplicate lines or lines starting with space in the history.
# # See bash(1) for more options
HISTCONTROL=ignoreboth

# # append to the history file, don't overwrite it
shopt -s histappend

# # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=1000000

# bind '"\e[A":history-search-backward'
# bind '"\e[B":history-search-forward'
# bind '"\e[C": forward-char'
# bind '"\e[D": backward-char'

export PROMPT_COMMAND="history -a; history -n"

if [[ $- == *i* ]]; then
    # Another CTRL-R script to insert the selected command from history into the command line/region
    __fzf_history ()
    {
        builtin history -a;
        builtin history -c;
        builtin history -r;
        builtin typeset \
            READLINE_LINE_NEW="$(
                HISTTIMEFORMAT= builtin history |
                command fzf +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
                command sed '
                    /^ *[0-9]/ {
                        s/ *\([0-9]*\) .*/!\1/;
                        b end;
                    };
                    d;
                    : end
                '
            )";

            if
                    [[ -n $READLINE_LINE_NEW ]]
            then
                    builtin bind '"\er": redraw-current-line'
                    builtin bind '"\e^": magic-space'
                    READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                    READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
            else
                    builtin bind '"\er":'
                    builtin bind '"\e^":'
            fi
    }

    builtin set -o histexpand;
    builtin bind -x '"\C-x1": __fzf_history';
    builtin bind '"\C-r": "\C-x1\e^\er"'
fi
