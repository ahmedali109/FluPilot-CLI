#!/bin/bash

GUM_CONFIRM_STYLE=(
  --affirmative="YES"
  --negative="NO"

  --prompt.foreground="#6366F1"             # Indigo-500 (modern blue-purple)
  --prompt.align=center
  --prompt.padding="1 2"
  --prompt.bold

  --selected.background="#22D3EE"           # Cyan-400 (modern accent)
  --selected.foreground="#0F172A"           # Slate-900 (very dark for contrast)

  --unselected.background="#FBBF24"         # Amber-400 (modern yellow)
  --unselected.foreground="#334155"         # Slate-700 (modern dark gray)
)
