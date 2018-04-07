#!/bin/bash

# Usage: pcfup help
# Description: Show this help

echo "pcfup makes it easy to upgrade your PCF installation manually

Usage: pcfup [parameters] <command> [args...]

Parameters: $OPTIONS_HELP

Commands:"

for command in $(ls -1 $PCFUP_DIR/commands/*); do
  COMMAND_USAGE=$(cat $command | grep "^# Usage:" | cut -d' ' -f3-)
  if [ -n "$COMMAND_USAGE" ]; then
    echo "  $COMMAND_USAGE"

    COMMAND_DESCRIPTION=$(cat $command | grep "^# Description:" | cut -d' ' -f3-)
    if [ -n "$COMMAND_DESCRIPTION" ]; then
      echo "    $COMMAND_DESCRIPTION"
    fi
  fi


done

echo "

* not implemented yet"