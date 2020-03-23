#!/bin/bash

free -h |
    head -2 |
    tail -1 |
    awk "match(\$0, /Mem:\s*[0-9a-zA-Z\.]*\s*([0-9a-zA-Z\.]*)\s.*/, array) {print array[1]}" |
    cat