#!/bin/bash

. $PCFUP_DIR/methods/log.sh

function execPivnet() {
  logDebug "execute pivnet $@"
  pivnet $@
}
