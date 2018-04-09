#!/bin/bash

. $PCFUP_DIR/methods/log.sh
. $PCFUP_DIR/methods/exec-pivnet.sh

function downloadStemcell() {
  STEMCELL_VERSION=$1
  logInfo "download stemcell $STEMCELL_VERSION"

  product_slug="stemcells"
  SC_FILE_PATH=$(ls -1 $DOWNLOADS_FOLDER/bosh-stemcell*$STEMCELL_VERSION*$IAAS*.tgz | head -1 2>> /dev/null)
  logDebug "path to stemcell: $SC_FILE_PATH--"
  if [[ "$SC_FILE_PATH" == "" ]]; then
    execPivnet download-product-files -p "$product_slug" -r $STEMCELL_VERSION -g "*${IAAS}*" --accept-eula -d $DOWNLOADS_FOLDER/
  fi
}