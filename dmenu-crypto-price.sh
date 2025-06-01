#!/bin/bash

coin=$(echo "" | dmenu -p "Enter crypto coin name (e.g. bitcoin):")
if [[ -z "$coin" ]]; then
  notify-send "Crypto Info" "No coin name entered."
  exit 1
fi

url="https://api.coingecko.com/api/v3/coins/$coin"
response=$(curl -s "$url")
if echo "$response" | jq -e '.error' >/dev/null; then
  error_msg=$(echo "$response" | jq -r '.error')
  notify-send "Crypto Info" "Error: $error_msg"
  exit 1
fi

coin_name=$(echo "$response" | jq -r '.name')
price_usd_raw=$(echo "$response" | jq -r '.market_data.current_price.usd')
price_usd=$(printf "%'.2f" "$price_usd_raw")
change_14h=$(echo "$response" | jq -r '.market_data.price_change_percentage_24h')
img_url=$(echo "$response" | jq -r '.image.small')
msg="Name: $coin_name \nPrice: \$${price_usd} \n24h Change: ${change_14h}%"

tmp_img=$(mktemp --suffix=.png)
curl -s -o "$tmp_img" "$img_url"

notify-send -i "$tmp_img" "Crypto Info" "$msg"

rm "$tmp_img"
