#!/bin/sh

current_session_id=$(tmux display-message -p '#{session_id}' 2>/dev/null)
waiting_sessions=""

while read -r session_id waiting; do
  if [ "$waiting" = "1" ] && [ "$session_id" != "$current_session_id" ]; then
    session_num=${session_id#\$}
    if [ -n "$waiting_sessions" ]; then
      waiting_sessions="$waiting_sessions $session_num"
    else
      waiting_sessions="$session_num"
    fi
  fi
done <<EOF
$(tmux list-sessions -F '#{session_id} #{@opencode_waiting}' 2>/dev/null)
EOF

if [ -n "$waiting_sessions" ]; then
  printf ' #[fg=colour231,bg=colour160,bold] 🤖 %s ' "$waiting_sessions"
fi
