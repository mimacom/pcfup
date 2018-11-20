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

INSTALLATION_ZIP=$2
if [ ! -f $INSTALLATION_ZIP ]; then
    echo "installation.zip to import could not be found in '${INSTALLATION_ZIP}'"
    exit 1
fi

echo -n "Decryption passphrase (visible): "
read DECRYPTION_PASSPHRASE
execOM --decryption-passphrase $DECRYPTION_PASSPHRASE import-installation -i $INSTALLATION_ZIP