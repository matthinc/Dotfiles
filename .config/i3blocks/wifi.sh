#!/bin/bash
set -e
IF=wlp3s0

CONNECTED=$(
    nmcli |
    cat |
    grep "$IF: connected" |
    awk "match(\$0, /$IF:\sconnected\sto\s(.*)$/, array) {print array[1]}" |
    cat
)

if [ -z "$CONNECTED" ]
then
    echo "Not connected"
else
    echo $CONNECTED
fi