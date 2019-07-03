#!/bin/bash
B_CLASS="/sys/class/power_supply/BAT0"

echo "$(cat $B_CLASS/charge_now )*100/$(cat $B_CLASS/charge_full)" |
    bc |
    awk '{print $1"%"}' |
    awk "{print \$1\" ($(
        echo "$(cat $B_CLASS/cycle_count)"
    ))\"}" |
    cat
