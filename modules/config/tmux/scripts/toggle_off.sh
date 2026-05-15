#!/usr/bin/env bash

tmux set -u prefix
tmux set -u key-table
tmux set -s status-left "#{E:@local}"
tmux refresh-client -S
