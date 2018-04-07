#!/bin/bash

# Usage: pcfup pivnet-login <pivnet-auth-token>
# Description: Login with an authentication token to the Pivotal Network.

. $PCFUP_DIR/asserts/pivnet-available.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/log.sh
. $PCFUP_DIR/methods/exec-pivnet.sh

assertPivnetAvailable
assertNumberOfArguments 2 "pcfup pivnet-login <pivnet-auth-token>"

logInfo "login to pivnet"
execPivnet login --api-token=$2