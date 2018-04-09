#!/bin/bash

NUMBER_OF_ARGUMENTS=$#
function assertNumberOfArguments() {
  if [[ $NUMBER_OF_ARGUMENTS -ne $1 ]]; then
    logError "Usage: $2"
    exit 1
  fi
}