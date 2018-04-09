#!/bin/bash

# Usage: pcfup credentials
# Description: Extract and show useful BOSH and CF credentials.

. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/om-signed-in.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/exec-om.sh
. $PCFUP_DIR/methods/log.sh

assertOmAvailable
assertOmSignedIn
assertNumberOfArguments 1 "pcfup credentials"

logInfo "Getting credentials"

# BOSH Director credentials
if [ -z ${PCFUP_DIRECTOR_USER+x} ]; then
  DIRECTOR=$(execOM curl -p "/api/v0/deployed/director/credentials/director_credentials" 2>/dev/null)
  export PCFUP_DIRECTOR_USER=$(echo $DIRECTOR | jq -r ".credential.value.identity")
  export PCFUP_DIRECTOR_PASSWORD=$(echo $DIRECTOR | jq -r ".credential.value.password")
fi
logInfo "BOSH Director"
logInfo "  PCFUP_DIRECTOR_USER: ${PCFUP_DIRECTOR_USER}"
logInfo "  PCFUP_DIRECTOR_PASSWORD: ${PCFUP_DIRECTOR_PASSWORD}"

# BOSH DIRECTOR VM
if [ -z ${PCFUP_BOSH_VM_USER+x} ]; then
  BOSH_VM=$(execOM curl -p "/api/v0/deployed/director/credentials/vm_credentials" 2>/dev/null)
  export PCFUP_BOSH_VM_USER=$(echo ${BOSH_VM} | jq -r ".credential.value.identity")
  export PCFUP_BOSH_VM_PASSWORD=$(echo ${BOSH_VM} | jq -r ".credential.value.password")
fi
logInfo "BOSH Director VM"
logInfo "  PCFUP_BOSH_VM_USER: ${PCFUP_BOSH_VM_USER}"
logInfo "  PCFUP_BOSH_VM_PASSWORD: ${PCFUP_BOSH_VM_PASSWORD}"

# UAA Admin
export PCFUP_BOSH_UAA_ADMIN_ID="opsman"
export PCFUP_BOSH_UAA_ADMIN_SECRET=""
logInfo "BOSH UAA"
logInfo "  PCFUP_BOSH_UAA_ADMIN_ID: ${PCFUP_BOSH_UAA_ADMIN_ID}"
logInfo "  PCFUP_BOSH_UAA_ADMIN_SECRET: ${PCFUP_BOSH_UAA_ADMIN_SECRET}"


CF_GUID=$(execOM curl -p "/api/v0/deployed/products" 2>/dev/null | jq -r ".[] | .guid" | grep cf)
logDebug "CF deployment GUID: ${CF_GUID}"

# CF Admin User
if [ -z ${PCFUP_CF_ADMIN_USER+x} ]; then
  CF_ADMIN=$(execOM curl -p  "/api/v0/deployed/products/${CF_GUID}/credentials/.uaa.admin_credentials" 2>/dev/null)
  export PCFUP_CF_ADMIN_USER=$(echo ${CF_ADMIN} | jq -r ".credential.value.identity")
  export PCFUP_CF_ADMIN_PASSWORD=$(echo ${CF_ADMIN} | jq -r ".credential.value.password")
fi
logInfo "CF Admin"
logInfo "  PCFUP_CF_ADMIN_USER: ${PCFUP_CF_ADMIN_USER}"
logInfo "  PCFUP_CF_ADMIN_PASSWORD: ${PCFUP_CF_ADMIN_PASSWORD}"

# CF Admin Client
if [ -z ${PCFUP_CF_ADMIN_CLIENT_ID+x} ]; then
  CF_ADMIN_CLIENT=$(execOM curl -p  "/api/v0/deployed/products/${CF_GUID}/credentials/.uaa.admin_client_credentials" 2>/dev/null)
  export PCFUP_CF_ADMIN_CLIENT_ID=$(echo ${CF_ADMIN_CLIENT} | jq -r ".credential.value.identity")
  export PCFUP_CF_ADMIN_CLIENT_SECRET=$(echo ${CF_ADMIN_CLIENT} | jq -r ".credential.value.password")
fi
logInfo "  PCFUP_CF_ADMIN_CLIENT_ID: ${PCFUP_CF_ADMIN_CLIENT_ID}"
logInfo "  PCFUP_CF_ADMIN_CLIENT_SECRET: ${PCFUP_CF_ADMIN_CLIENT_SECRET}"