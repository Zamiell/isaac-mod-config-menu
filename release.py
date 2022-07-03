import os
import shutil
import subprocess
import time

SCRIPT_PATH = os.path.realpath(__file__)
SOURCE_MOD_DIRECTORY = os.path.dirname(SCRIPT_PATH)
TARGET_MOD_DIRECTORY = "C:\\Program Files (x86)\\Steam\\steamapps\\common\\The Binding of Isaac Rebirth\\mods\\!!mod config menu"
MOD_UPLOADER_PATH = "C:\\Program Files (x86)\\Steam\\steamapps\\common\\The Binding of Isaac Rebirth\\tools\\ModUploader\\ModUploader.exe"

def main():
    pass


if __name__ == "__main__":
    if os.path.exists(TARGET_MOD_DIRECTORY):
        shutil.rmtree(TARGET_MOD_DIRECTORY)

    shutil.copytree(
        SOURCE_MOD_DIRECTORY,
        TARGET_MOD_DIRECTORY,
        ignore=shutil.ignore_patterns(
            ".git",
            ".vscode",
            "steam",
            ".gitattributes",
            ".gitignore",
            "cspell.json",
            "release.py",
        ),
    )

    subprocess.Popen(
        [MOD_UPLOADER_PATH], cwd=TARGET_MOD_DIRECTORY
    )  # Popen will run it in the background
