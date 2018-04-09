#!/bin/bash

. $PCFUP_DIR/methods/log.sh
. $PCFUP_DIR/methods/is-stemcell-uploaded.sh
. $PCFUP_DIR/methods/download-stemcell.sh
. $PCFUP_DIR/methods/exec-om.sh

function ensureStemcellIsAvailable() {
  STEMCELL_VERSION=$1

  if [[ $(isStemcellUploaded $STEMCELL_VERSION && echo 0 || echo 1) == 1 ]]; then
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
