#!/bin/bash

# Usage: pcfup om -- <om-command>
# Description: Execute a 'om' tool command. For using parameters from the om tool, the '--' is necessary to avoid handling by pcfup.

. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/om-signed-in.sh

. $PCFUP_DIR/methods/exec-om.sh

assertOmAvailable
assertOmSignedIn

execOM ${@:2}