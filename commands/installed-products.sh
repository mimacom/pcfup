#!/bin/bash

# Usage: pcfup installed-products
# Description: List all installed products for your Operations Manager installation.

. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/om-signed-in.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/exec-om.sh

assertOmAvailable
assertOmSignedIn
assertNumberOfArguments 1 "pcfup installed-products"

execOM deployed-products