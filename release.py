import os
import re
import shutil
import subprocess
import sys

SCRIPT_PATH = os.path.realpath(__file__)
SOURCE_MOD_DIRECTORY = os.path.dirname(SCRIPT_PATH)
TARGET_MOD_DIRECTORY = "C:\\Program Files (x86)\\Steam\\steamapps\\common\\The Binding of Isaac Rebirth\\mods\\!!mod config menu"
MOD_UPLOADER_PATH = "C:\\Program Files (x86)\\Steam\\steamapps\\common\\The Binding of Isaac Rebirth\\tools\\ModUploader\\ModUploader.exe"
LUA_FILE_PATH = os.path.join(SOURCE_MOD_DIRECTORY, "scripts", "modconfig.lua")


def main():
    increment_lua_version()

    if os.path.exists(TARGET_MOD_DIRECTORY):
        shutil.rmtree(TARGET_MOD_DIRECTORY)

    shutil.copytree(
        SOURCE_MOD_DIRECTORY,
        TARGET_MOD_DIRECTORY,
        ignore=shutil.ignore_patterns(
            ".git",
            ".vscode",
            ".gitattributes",
            ".gitignore",
            "cspell.json",
            "release.py",
            "steam",
        ),
    )

    # By using "subprocess.run", the program will wait for the mod uploader to close.
    subprocess.run([MOD_UPLOADER_PATH], cwd=TARGET_MOD_DIRECTORY)

    shutil.rmtree(TARGET_MOD_DIRECTORY)


def increment_lua_version():
    if not os.path.exists(LUA_FILE_PATH):
        error("Failed to find the Lua file at: {}".format(LUA_FILE_PATH))

    with open(LUA_FILE_PATH) as f:
        text = f.read()

    match = re.search(r"local VERSION = (\d+)", text)
    if not match:
        error("Failed to find the version in the Lua file at: {}".format(LUA_FILE_PATH))

    version_string = match.group(1)
    version_number = int(version_string)
    new_version = version_number + 1

    text = re.sub(
        "local VERSION = {}".format(version_string),
        "local VERSION = {}".format(new_version),
        text,
    )
    text = re.sub("local IS_DEV = true", "local IS_DEV = false", text)

    with open(LUA_FILE_PATH, "w") as f:
        f.write(text)


def error(msg):
    printf("Error: {}".format(msg))
    sys.exit(1)


def printf(*args):
    print(*args, flush=True)


if __name__ == "__main__":
    main()
