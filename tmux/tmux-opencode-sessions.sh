#!/bin/sh

current_session_id=$(tmux display-message -p '#{session_id}' 2>/dev/null)
waiting_sessions=""
seen_sessions=""

while read -r session_id waiting command; do
  if [ "$waiting" = "1" ] && [ "$command" = "opencode" ] && [ "$session_id" != "$current_session_id" ]; then
    case " $seen_sessions " in
      *" $session_id "*)
        continue
        ;;
    esac

    seen_sessions="$seen_sessions $session_id"
    session_num=${session_id#\$}
    if [ -n "$waiting_sessions" ]; then
      waiting_sessions="$waiting_sessions $session_num"
    else
      waiting_sessions="$session_num"
    fi
  fi
done <<EOF
$(tmux list-windows -a -F '#{session_id} #{@opencode_window_waiting} #{pane_current_command}' 2>/dev/null)
EOF

if [ -n "$waiting_sessions" ]; then
  printf ' #[fg=colour231,bg=colour160,bold] 🤖 %s ' "$waiting_sessions"
fi
