#!/bin/sh

Z_DIRECTORY=$HOME/.z
complete -C $Z_DIRECTORY/z_sourcing.sh z

function z {
    ruby $Z_DIRECTORY/z.rb $@ > /tmp/z.output
    source /tmp/z.output
    cat /dev/null > /tmp/z.output
}
