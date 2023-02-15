import os
import re
import shutil
import subprocess
import sys

SCRIPT_PATH = os.path.realpath(__file__)
SOURCE_MOD_DIRECTORY = os.path.dirname(SCRIPT_PATH)
LUA_FILE_PATH = os.path.join(SOURCE_MOD_DIRECTORY, "scripts", "modconfig.lua")
METADATA_XML_PATH = os.path.join(SOURCE_MOD_DIRECTORY, "metadata.xml")


def main():
    if not is_git_clean():
        printf(
            "Error: The current working directory must be clean before releasing a new version. Please push your changes to Git."
        )
        sys.exit(1)

    # Validate that we can push and pull to the repository and that all commits are remotely synced.
    subprocess.run(["git", "branch", "--set-upstream-to=origin/main", "main"])
    subprocess.run(["git", "pull", "--rebase"])
    subprocess.run(["git", "push", "--set-upstream", "origin", "main"])

    new_version = increment_lua_version()
    set_metadata_xml_version(new_version)

    subprocess.run(["git", "add", "--all"])
    subprocess.run(["git", "commit", "--message", f"chore: release {new_version}"])
    subprocess.run(["git", "push", "--set-upstream", "origin", "main"])

    printf(f"Released version: {new_version}")


def is_git_clean():
    stdout_bytes = subprocess.check_output(["git", "status", "--short"])
    stdout = stdout_bytes.decode("utf-8")
    trimmed_stdout = stdout.strip()
    return len(trimmed_stdout) == 0


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
