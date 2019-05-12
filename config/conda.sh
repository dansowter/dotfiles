__conda_setup="$('/home/dansowter/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dansowter/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dansowter/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dansowter/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
