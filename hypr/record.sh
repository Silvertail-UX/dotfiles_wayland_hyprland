#!/bin/bash

if pgrep -x wf-recorder > /dev/null; then
    pkill -INT wf-recorder
    notify-send -i process-stop "Grabación detenida"
    exit 0
else
    notify-send -i camera-video "   Recording in progress"
fi

arg="$1"
audio="$(pactl get-default-sink)"
mic="$(pactl get-default-source)"
file="$HOME/Videos/$(date +%F_%H-%M-%S).mp4"

if [ "$arg" == "audio_only" ]; then
  wf-recorder --audio="${audio}.monitor" -f "$file" \
    -c libx264 \
    -p pix_fmt=yuv420p \
    -p preset=medium \
    -p crf=18 \
    -r 60
elif [ "$arg" == "microphone_only" ]; then
  wf-recorder --audio="${mic}" -f "$file"\
    -c libx264 \
    -p pix_fmt=yuv420p \
    -p preset=medium \
    -p crf=18 \
    -r 60
elif [ "$arg" == "screen_only" ]; then
  wf-recorder -f "$file"\
    -c libx264 \
    -p pix_fmt=yuv420p \
    -p preset=medium \
    -p crf=18 \
    -r 60
fi

