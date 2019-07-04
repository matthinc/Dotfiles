#!/bin/bash
curl -s "https://getdaytrends.com/de/germany/" |
    awk "match(\$0, /.*<b>(#[a-zA-Z0-9]+)<\/b>.*/, array) {print array[1]}" |
    head -3 |
    tr '\n' ' '