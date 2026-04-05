#!/usr/bin/env bash

# 1. Get hostnames from ~/.ssh/config (ignoring wildcards and includes)
# 2. Pipe to fuzzel in dmenu mode
# 3. Execute ssh in your preferred terminal (e.g., foot, alacritty)

host=$(grep -i '^host ' ~/.ssh/config | awk '{print $2}' | grep -v '*' | fuzzel --dmenu -p "SSH to: ")

if [ -n "$host" ]; then
    alacritty -e ssh "$host"
fi


