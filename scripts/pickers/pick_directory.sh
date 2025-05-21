#!/bin/bash

# --- Cross-platform directory picker ---
function pick_dir() {
    python3 -c 'import tkinter as tk; from tkinter import filedialog; tk.Tk().withdraw(); print(filedialog.askdirectory())'
}
