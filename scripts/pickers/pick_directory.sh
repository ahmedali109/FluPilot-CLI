#!/bin/bash

function pick_dir_windows(){
  python -c "import tkinter as tk; from tkinter import filedialog; tk.Tk().withdraw(); print(filedialog.askdirectory())"
}

function pick_dir_unix(){
   python3 -c "import tkinter as tk; from tkinter import filedialog; tk.Tk().withdraw(); print(filedialog.askdirectory())"
}

# --- Cross-platform directory picker ---
function pick_dir() {
    # Check if the script is running in a Windows environment
    # and use the appropriate method to pick a directory
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
      pick_dir_windows
    # Check if the script is running in a Unix-like environment
    elif [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
      pick_dir_unix
    # If the script is running in an unknown environment, print an error message
    else
      echo "Unsupported OS: $OSTYPE"
      return 1
    fi
}
