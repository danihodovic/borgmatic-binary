# -*- mode: python ; coding: utf-8 -*-
import sys
import importlib
from pathlib import Path

block_cipher = None

# https://github.com/pyinstaller/pyinstaller/wiki/Recipe-remove-tkinter-tcl
sys.modules["FixTk"] = None

# Include borgmatic yaml definitions
borgmatic_dir = Path(importlib.import_module("borgmatic").__file__).parent
datas = [(str(borgmatic_dir / "config"), "borgmatic/config")]

a = Analysis(
    ["main.py"],
    binaries=[],
    datas=datas,
    hiddenimports=[],
    hookspath=[],
    runtime_hooks=[],
    excludes=["PyInstaller", "FixTk", "tcl", "tk", "_tkinter", "tkinter", "Tkinter"],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)
pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)
exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name="borgmatic",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
)
