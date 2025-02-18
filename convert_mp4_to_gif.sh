#!/bin/bash

# How to use
# ./convert_mp4_to_gif.sh input.mp4 output.gif
input_file="$1"
output_file="$2"

# Generate palette
ffmpeg -i "$input_file" -vf "fps=16,scale=iw:-1:flags=lanczos,palettegen" tmp_palette.png

# Create the GIF
ffmpeg -i "$input_file" -i tmp_palette.png -filter_complex "fps=16,scale=iw:-1:flags=lanczos[x];[x][1:v]paletteuse" "$output_file"

rm tmp_palette.png

