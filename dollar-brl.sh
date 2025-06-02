#!/bin/bash

response=$(curl -s "https://open.er-api.com/v6/latest/USD")
brl=$(echo "$response" | jq '.rates.BRL')
notify-send -i "" "USD => BRL" "R\$ $brl"
