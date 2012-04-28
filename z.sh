#!/bin/sh

Z_DIRECTORY=/Users/michaelsteger/bin/

function z {
    ruby $Z_DIRECTORY/z.rb $@ > /tmp/z.output
    source /tmp/z.output
    #cat /dev/null > /tmp/z.output
}
