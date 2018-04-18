#!/bin/bash

# Usage: pcfup help
# Description: Show this help

echo "pcfup makes it easy to upgrade your PCF installation manually

Usage: pcfup [parameters] <command> [args...]

Parameters: $OPTIONS_HELP

Commands:"

cat $PCFUP_DIR/commands/*.sh | grep -E "^# (Usage|Description):" | sed "s/# Usage:/ /" | sed "s/# Description:/   /"

echo "
* not implemented yet"