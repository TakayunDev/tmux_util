#!/bin/bash

function find_pane_by_title() {
  local PANE_TITLE
  PANE_TITLE=$1
  RET=$(tmux list-panes -aF"#S:#I.#P #T"|xargs -n2 bash -c "[ \"\$1\" = "$PANE_TITLE" ] && echo \$0")
  echo "$RET"
}

# test
tmux split-window -h
tmux select-pane -T "MyTitle"
tmux split-window -h
tmux select-pane -T "MyTitle2"
sleep 1
RET=$(find_pane_by_title "MyTitle")
RET2=$(find_pane_by_title "MyTitle2")
echo $RET $RET2
sleep 1
tmux send -t $RET  'exit'
tmux send -t $RET2 'exit'
sleep 1
tmux send -t $RET  C-m
tmux send -t $RET2 C-m

