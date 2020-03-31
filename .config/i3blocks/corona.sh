#!/bin/bash
curl -s https://coronavirus-tracker-api.herokuapp.com/v2/locations | jq -r '.latest.confirmed'
