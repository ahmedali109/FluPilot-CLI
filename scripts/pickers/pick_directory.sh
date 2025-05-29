#!/bin/bash

function pick_dir_windows(){
  local start_dir="${1:-$HOME}"
  python -c "import tkinter as tk; from tkinter import filedialog; tk.Tk().withdraw(); print(filedialog.askdirectory(initialdir='$start_dir'))"
}

function pick_dir_unix(){
   local start_dir="${1:-$HOME}"
   python3 -c "import tkinter as tk; from tkinter import filedialog; tk.Tk().withdraw(); print(filedialog.askdirectory(initialdir='$start_dir'))"
}

# --- Cross-platform directory picker ---
function pick_dir() {
    local arg="${1:-}"
    # Check if the script is running in a Windows environment
    # and use the appropriate method to pick a directory
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
      pick_dir_windows "$arg"
    # Check if the script is running in a Unix-like environment
    elif [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
      pick_dir_unix "$arg"
    # If the script is running in an unknown environment, print an error message
    else
      echo "Unsupported OS: $OSTYPE"
      return 1
    fi
}
