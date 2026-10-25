#!/usr/bin/env bash

# 1. Get hostnames from ~/.ssh/config (ignoring wildcards and includes)
# 2. Pipe to fuzzel in dmenu mode
# 3. Open a zellij session named after the host and ssh into it, in alacritty

host=$(grep -i '^host ' ~/.ssh/config | awk '{print $2}' | grep -v '*' | fuzzel --dmenu -p "SSH to: ")

if [ -n "$host" ]; then
    exec alacritty -e zellij attach -c "$host" --close-on-exit -- ssh "$host"
fi
