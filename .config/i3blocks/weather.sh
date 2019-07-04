#!/bin/bash
curl -s "wttr.in/Munich?format=3" |
    awk "match(\$0, /.*\+(.*)$/, array) {print array[1]}"