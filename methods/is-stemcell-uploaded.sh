#!/bin/bash

. $PCFUP_DIR/methods/exec-om.sh
. $PCFUP_DIR/methods/log.sh

function isStemcellUploaded() {
  STEMCELL_VERSION=$1
  STEMCELL_VERSION_PREFIX=$(echo $1 | awk -F. '{print $1}')
  STEMCELL_VERSION_SUFFIX=$(echo $1 | awk -F. '{print $2}')

  if [[ -z $STEMCELL_VERSION_SUFFIX ]]; then
    STEMCELL_VERSION_SUFFIX=0
  fi

  logDebug "search for stemcell $STEMCELL_VERSION with prefix $STEMCELL_VERSION_PREFIX"

  diagnostic_report=$(
    execOM curl --silent --path "/api/v0/diagnostic_report"
  )

  stemcell=$(
    echo $diagnostic_report |
    jq \
      -r \
      --arg version "$STEMCELL_VERSION_PREFIX" \
      --arg glob "$IAAS" \
    '.stemcells[] | select(contains($version) and contains($glob))' |
    sort -n -r |
    head -1
  )

  if [[ -z "$stemcell" ]]; then
    logDebug "no stemcell is available, exit"
    return 1
  fi

  stemcell_suffix_available=$(echo $stemcell | sed -E "s/.*-$STEMCELL_VERSION_PREFIX\.([0-9]+)-.*/\\1/")

  if [[ $stemcell_suffix_available -ge $STEMCELL_VERSION_SUFFIX ]]; then
    logDebug "available stemcell: $stemcell"
    return 0
  else
    return 1
  fi
}