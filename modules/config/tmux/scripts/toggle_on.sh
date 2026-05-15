#!/usr/bin/env bash

tmux set prefix None
tmux set key-table off
tmux refresh-client -S
tmux set -s status-left "#{E:@remote}"
tmux if -F '#{pane_in_mode}' 'send-keys -X cancel'
