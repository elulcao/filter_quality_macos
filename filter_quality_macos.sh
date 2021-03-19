#!/bin/bash

# Exit if any command has a non-zero exit status
set -e

# Common files
LIBFILTER="/Library/Filters"
SYSFILTER="/System/Library/Filters"
SOURCE=$SYSFILTER"/Reduce File Size.qfilter"
TARGET=$LIBFILTER"/Reduce File Size Quality.qfilter"

# Commands
SED="/usr/bin/sed"
MKDIR="/bin/mkdir"
CP="/bin/cp"

echo "Creating directory: $LIBFILTER"
$MKDIR -p $LIBFILTER # Create direcotry for custom filter

echo "Copying source: $SOURCE"
$CP -- "$SOURCE" "$TARGET" # Copy macOS Filter to new directory

# Overwrite the $TARGET file with custom values
echo "Modifying target: $TARGET"
$SED -i '' "s/0.0/0.6/" "$TARGET" # Compression quality 0 - 1
$SED -i '' "s/0.5/0.6/" "$TARGET" # Scale factor 0 - 1
$SED -i '' "s/512/800/" "$TARGET" # SVGA Resolution
$SED -i '' "s/128/600/" "$TARGET" # SVGA Resolution
$SED -i '' "s/Reduce.*</Reduce\ File\ Size\ Quality</" "$TARGET" # Filter name
