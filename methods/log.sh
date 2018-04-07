#!/bin/bash

function logDebug() {
  if [[ $ENABLE_VERBOSE -eq 1 ]]; then
    >&2 echo "[DEBUG] $@"
  fi
}

function logInfo() {
  >&2 echo "[INFO] $@"
}

function logError() {
  >&2 echo "[ERR] $@"
}
