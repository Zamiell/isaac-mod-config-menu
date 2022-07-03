import os
import shutil

SCRIPT_PATH = os.path.realpath(__file__)
SOURCE_MOD_DIRECTORY = os.path.dirname(SCRIPT_PATH)
TARGET_MOD_DIRECTORY = "C:\\Program Files (x86)\\Steam\\steamapps\\common\\The Binding of Isaac Rebirth\\mods\\!!mod config menu"

METADATA_XML = "metadata.xml"
SOURCE_METADATA_XML = os.path.join(SOURCE_MOD_DIRECTORY, METADATA_XML)
TARGET_METADATA_XML = os.path.join(TARGET_MOD_DIRECTORY, METADATA_XML)

# Copy back the "metadata.xml" file, since it will have an incremented version number.
shutil.copyfile(TARGET_METADATA_XML, SOURCE_METADATA_XML)

# Clean up the target mod directory.
shutil.rmtree(TARGET_MOD_DIRECTORY)
