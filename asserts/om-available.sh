#!/bin/bash

function assertOmAvailable() {
  type om 2>>/dev/null >>/dev/null \
    || type om-linux 2>>/dev/null >>/dev/null \
    || (logError "failed to find om, please use 'pcfup download-tools' or install om manually." ; exit 10)

  if [ -z ${OM_TARGET+x} ]; then
    logError "Please set OM_TARGET"
    exit 1
  fi
  if [ -z ${OM_USERNAME+x} ]; then
    logError "Please set OM_USERNAME"
    exit 1
  fi
  if [ -z ${OM_PASSWORD+x} ]; then
    logError "Please set OM_PASSWORD"
    exit 1
  fi
}