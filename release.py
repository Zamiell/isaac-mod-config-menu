import os
import re
import shutil
import subprocess
import sys

SCRIPT_PATH = os.path.realpath(__file__)
SOURCE_MOD_DIRECTORY = os.path.dirname(SCRIPT_PATH)
TARGET_MOD_DIRECTORY = "C:\\Program Files (x86)\\Steam\\steamapps\\common\\The Binding of Isaac Rebirth\\mods\\!!mod config menu"
LUA_FILE_PATH = os.path.join(SOURCE_MOD_DIRECTORY, "scripts", "modconfig.lua")
METADATA_XML_PATH = os.path.join(SOURCE_MOD_DIRECTORY, "metadata.xml")


def main():
    new_version = increment_lua_version()
    set_metadata_xml_version(new_version)

    subprocess.run(["git", "add", "--all"])
    subprocess.run(["git", "commit", "--message", f"chore: release {new_version}"])
    subprocess.run(["git", "push", "--set-upstream", "origin", "main"])

    printf(f"Released version: {new_version}")


def increment_lua_version():
    if not os.path.exists(LUA_FILE_PATH):
        error(f"Failed to find the Lua file at: {LUA_FILE_PATH}")

    with open(LUA_FILE_PATH) as f:
        text = f.read()

    match = re.search(r"local VERSION = (\d+)", text)
    if not match:
        error(f"Failed to find the version in the Lua file at: {LUA_FILE_PATH}")

    version_string = match.group(1)
    version_number = int(version_string)
    new_version = version_number + 1

    text = re.sub(
        f"local VERSION = {version_string}",
        f"local VERSION = {new_version}",
        text,
    )
    text = re.sub("local IS_DEV = true", "local IS_DEV = false", text)

    with open(LUA_FILE_PATH, "w", newline="\n") as f:
        f.write(text)

    return new_version


def set_metadata_xml_version(new_version: str):
    if not os.path.exists(METADATA_XML_PATH):
        error(f'Failed to find the "metadata.xml" file at: {METADATA_XML_PATH}')

    with open(METADATA_XML_PATH) as f:
        text = f.read()

    text = re.sub(
        r"<version>(.+?)</version>",
        f"<version>{new_version}</version>",
        text,
    )

    with open(METADATA_XML_PATH, "w", newline="\n") as f:
        f.write(text)


def error(msg: str):
    printf(f"Error: {msg}")
    sys.exit(1)


def printf(*args):
    print(*args, flush=True)


if __name__ == "__main__":
    main()
