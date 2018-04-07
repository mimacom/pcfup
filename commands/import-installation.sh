#!/bin/bash

# Usage: pcfup import-installation <file>
# Description: Import your Operations Manager installation to an new Operations Manager.

. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/om-signed-in.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/exec-om.sh

assertOmAvailable
assertOmSignedIn
assertNumberOfArguments 2 "pcfup import-installation <filename>"

echo -n "Decryption passphrase (visible): "
read DECRYPTION_PASSPHRASE
execOM import-installation -i $2 -dp $DECRYPTION_PASSPHRASE