#!/bin/bash

# Usage: pcfup stemcell-uploaded <stemcell-version>
# Description: Ensure that a specific stemcell of a certain type (trusty|xenial|windows) is uploaded to Operations Manager

. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/om-signed-in.sh
. $PCFUP_DIR/asserts/iaas-available.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/is-stemcell-uploaded.sh

assertIaasAvailable
assertNumberOfArguments 3 "pcfup stemcell-uploaded <stemcell-version> [stemcell-type]"

STEMCELL_VERSION=$2
STEMCELL_TYPE=$3
if [ -z $STEMCELL_TYPE ]; then
    STEMCELL_TYPE="trusty"
fi

exit $(isStemcellUploaded $STEMCELL_VERSION $STEMCELL_TYPE && echo 0 || echo 1)