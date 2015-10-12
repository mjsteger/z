#!/bin/sh

Z_DIRECTORY=$HOME/.z
if [ -n "$ZSH_VERSION" ]; then
    autoload -U _z
    compdef _z z
elif [ -n "$BASH_VERSION" ]; then
    complete -C $Z_DIRECTORY/z_sourcing.sh z
fi

function z {
    ruby $Z_DIRECTORY/z.rb $@ > /tmp/z.output
    source /tmp/z.output
    cat /dev/null > /tmp/z.output
}
