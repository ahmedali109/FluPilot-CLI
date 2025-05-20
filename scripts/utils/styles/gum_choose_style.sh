#!/bin/bash

GUM_CONFIRM_STYLE=(
  --affirmative="YES"
  --negative="NO"

  --prompt.foreground="#00BFFF"             # Bright deep sky blue
  --prompt.align=center
  --prompt.padding="1 2"
  --prompt.bold

  --selected.background="#00BFFF"           # Bright green background
  --selected.foreground="#FFFFFF"           # Black text for contrast

  --unselected.background="#FF0000"         # Bright red background
  --unselected.foreground="#FFFFFF"         # White text for clarity
)
