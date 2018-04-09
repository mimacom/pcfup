#!/bin/bash

. $PCFUP_DIR/methods/exec-om.sh

function isStemcellUploaded() {
  STEMCELL_VERSION=$1
  diagnostic_report=$(
    execOM curl --silent --path "/api/v0/diagnostic_report"
  )

  stemcell=$(
    echo $diagnostic_report |
    jq \
      --arg version "$STEMCELL_VERSION" \
      --arg glob "$IAAS" \
    '.stemcells[] | select(contains($version) and contains($glob))'
  )

  if [[ -z "$stemcell" ]]; then
    return 1
  else
    return 0
  fi
}