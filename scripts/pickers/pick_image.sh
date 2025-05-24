#!/bin/bash

# --- Cross-platform file picker ---

# Function to pick images in a Windows environment
function pick_img_windows(){
  python -c "import tkinter as tk; from tkinter import filedialog; tk.Tk().withdraw(); print(';'.join(filedialog.askopenfilenames(title='📷 Select Project Images', filetypes=[('Image Files', '*.png *.jpg *.jpeg *.gif *.bmp *.svg')])))"
}

# Function to pick images in a Unix-like environment
function pick_img_unix(){
  python3 -c "import tkinter as tk; from tkinter import filedialog; tk.Tk().withdraw(); print(';'.join(filedialog.askopenfilenames(title='Select Project Images', filetypes=[('Image Files', '*.png *.jpg *.jpeg *.gif *.bmp *.svg')])))"
}

# --- Cross-platform directory picker ---
function pick_img() {
    # Check if the script is running in a Windows environment
    # and use the appropriate method to pick a directory
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
      pick_img_windows
    # Check if the script is running in a Unix-like environment
    elif [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
      pick_img_unix
    # If the script is running in an unknown environment, print an error message
    else
      echo "Unsupported OS: $OSTYPE"
      return 1
    fi
}
