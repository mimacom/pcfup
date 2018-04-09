#!/bin/bash

# Usage: pcfup available-product-versions
# Description: List available versions of a product inside the Pivotal Network.

. $PCFUP_DIR/asserts/pivnet-available.sh
. $PCFUP_DIR/asserts/pivnet-signed-in.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/exec-pivnet.sh

assertPivnetAvailable
assertPivnetSignedIn
assertNumberOfArguments 2 "pcfup available-product-versions <product>"

PRODUCT=$2
execPivnet releases -p $PRODUCT | less