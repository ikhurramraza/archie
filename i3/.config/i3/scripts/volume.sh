#!/bin/sh

set -eu

pactl_output="$(pactl list sinks | grep -P "^\s*Volume|^\s*Mute" | tail -n2)"

volume="$(echo "$pactl_output" | tr ' ' '\n' | grep -m1 '%')"
label="$(echo "$pactl_output" | awk '/Mute/ { print $2 }' | sed -e 's/no/󰕾/' | sed -e 's/yes/󰸈/')"

echo "$label $volume"
