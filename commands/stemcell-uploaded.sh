#!/bin/bash

# Usage: pcfup stemcell-uploaded <stemcell-version>
# Description: Ensure that a specific stemcell is uploaded to Operations Manager

. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/om-signed-in.sh
. $PCFUP_DIR/asserts/iaas-available.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/is-stemcell-uploaded.sh

assertIaasAvailable
assertNumberOfArguments 2 "pcfup stemcell-uploaded <stemcell-version>"

STEMCELL_VERSION=$2

exit $(isStemcellUploaded $STEMCELL_VERSION && echo 0 || echo 1)