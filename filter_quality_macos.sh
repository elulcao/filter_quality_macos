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
$SED -i '' "28s/0.0/0.7/" "$TARGET" # Compression quality 0 - 1
$SED -i '' "34s/0.0/0.7/" "$TARGET" # Scale factor 0 - 1
$SED -i '' "38s/512/800/" "$TARGET" # SVGA Resolution
$SED -i '' "40s/128/600/" "$TARGET" # SVGA Resolution
$SED -i '' "48s/Reduce.*</Reduce\ File\ Size\ Quality</" "$TARGET" # Filter name
