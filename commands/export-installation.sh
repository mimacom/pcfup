#!/bin/bash

# Usage: pcfup export-installation <file>
# Description: Export your Operations Manager installation to a local zip-file, necessary for Operations Manager upgrade.

. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/om-signed-in.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/exec-om.sh

assertOmAvailable
assertOmSignedIn
assertNumberOfArguments 2 "pcfup export-installation <filename>"

mkdir -p $(dirname $2)
execOM export-installation -o $2