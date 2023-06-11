#!/bin/sh

set -eu

count="$(checkupdates | wc -l)"

[ "$count" = "0" ] || echo "󰦗 $count"
