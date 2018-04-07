#!/bin/bash

# Usage: pcfup wait-for-installation
# Description: Blocks the console until the current running installation is finished. The exit code indicates, whether the installation was successful (=0) or not (!=0).

. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/om-signed-in.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/log.sh
. $PCFUP_DIR/methods/exec-om.sh

assertOmAvailable
assertOmSignedIn
assertNumberOfArguments 1 "pcfup wait-for-installation"

INSTALLATION_ID=$(execOM curl -p /api/v0/installations 2>> /dev/null | jq .installations[0].id)

logInfo "waiting for status of installation $INSTALLATION_ID"

while true; do
  STATUS=$(execOM curl -p /api/v0/installations/$INSTALLATION_ID 2>> /dev/null |jq -j .status)

  logDebug "current status of installation is '$STATUS'"

  if [ "$STATUS" != 'running' ]; then
    logInfo "upgrade is no longer running, exit application."

    if [ "$STATUS" == 'succeeded' ]; then
      exit 0
    else
      exit 100
    fi
  fi

  sleep 1m;
done
