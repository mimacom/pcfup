#!/bin/bash

. $PCFUP_DIR/methods/log.sh
. $PCFUP_DIR/methods/download-stemcell.sh
. $PCFUP_DIR/methods/exec-om.sh

function ensureStemcellIsAvailable() {
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
    logDebug "need to install $STEMCELL_VERSION / $IAAS"
    downloadStemcell $STEMCELL_VERSION
    SC_FILE_PATH=$(ls -1 $DOWNLOADS_FOLDER/bosh-stemcell*$STEMCELL_VERSION*$IAAS*.tgz | head -1)

    if [ ! -f "$SC_FILE_PATH" ]; then
      logError "stemcell file not found!"
      exit 1
    fi

    logInfo "upload $STEMCELL_VERSION to OpsManager"
    execOM upload-stemcell -s $SC_FILE_PATH
  else
    logDebug "$STEMCELL_VERSION already installed"
  fi
}
