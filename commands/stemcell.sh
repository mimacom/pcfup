#!/bin/bash

# Usage: pcfup stemcell <stemcell>
# Description: Download a stemcell from Pivotal Network and install it to the Operations Manager.

. $PCFUP_DIR/asserts/pivnet-available.sh
. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/pivnet-signed-in.sh
. $PCFUP_DIR/asserts/om-signed-in.sh
. $PCFUP_DIR/asserts/iaas-available.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/ensure-stemcell-is-available.sh

assertPivnetAvailable
assertOmAvailable
assertPivnetSignedIn
assertOmSignedIn
assertIaasAvailable
assertNumberOfArguments 2 "pcfup stemcell <version>"

ensureStemcellIsAvailable $2