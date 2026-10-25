#!/usr/bin/env bash

# 1. Get session names from zellij (bare names, no formatting)
# 2. Pipe to fuzzel in dmenu mode; unmatched input is passed through as-is
# 3. Attach in alacritty, creating the session if it doesn't exist yet

session=$(zellij list-sessions -n -s 2>/dev/null | fuzzel --dmenu -p "Zellij session: ")

if [ -n "$session" ]; then
    exec alacritty -e zellij attach -c "$session"
fi
