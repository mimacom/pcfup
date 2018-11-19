#!/bin/bash

# Usage: pcfup download-product <product> <version>
# Description: Download a product from Pivotal Network, including the necessary stemcell.

. $PCFUP_DIR/asserts/pivnet-available.sh
. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/pivnet-signed-in.sh
. $PCFUP_DIR/asserts/om-signed-in.sh
. $PCFUP_DIR/asserts/iaas-available.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/log.sh
. $PCFUP_DIR/methods/download-stemcell.sh
. $PCFUP_DIR/methods/exec-om.sh
. $PCFUP_DIR/methods/exec-pivnet.sh
. $PCFUP_DIR/methods/ensure-stemcell-is-available.sh
. $PCFUP_DIR/methods/get-product-info.sh

assertPivnetAvailable
assertOmAvailable
assertPivnetSignedIn
assertIaasAvailable
assertNumberOfArguments 3 "pcfup download-product <product> <version>"

PRODUCT=$2
VERSION=$3
PRODUCT_DOWNLOAD_FOLDER=$DOWNLOADS_FOLDER/$PRODUCT/$VERSION

# download product if not yet done
mkdir -p $PRODUCT_DOWNLOAD_FOLDER
if [[ $(ls -1 $PRODUCT_DOWNLOAD_FOLDER/*.pivotal || echo "1") == "1" ]]; then
  logInfo "download $PRODUCT ($VERSION) from pivnet..."
  execPivnet download-product-files -p $PRODUCT -r $VERSION -d $PRODUCT_DOWNLOAD_FOLDER --glob=*.pivotal --accept-eula
else
  logInfo "Product ${PRODUCT}/${VERSION} already downloaded to: '$PRODUCT_DOWNLOAD_FOLDER'"
fi

# determine stemcell
PRODUCT_FILE=$(ls -1 $PRODUCT_DOWNLOAD_FOLDER/$PRODUCT*.pivotal 2>> /dev/null | head -1)
if [[ "$PRODUCT_FILE" == "" ]]; then
  PRODUCT_FILE=$(ls -1 $PRODUCT_DOWNLOAD_FOLDER/*.pivotal | head -1)
fi
logDebug "parse $PRODUCT_FILE to determine the necessary stemcell version."

getProductInfo $PRODUCT_FILE

# download stemcell if not yet done
if [ -n "$STEMCELL_VERSION" ]; then
  SC_FILE_PATH=$(ls -1 $DOWNLOADS_FOLDER/bosh-stemcell*$STEMCELL_VERSION*$IAAS*.tgz | head -1)

  if [ ! -f "$SC_FILE_PATH" ]; then
    logInfo "downloading stemcell ${STEMCELL_VERSION} from pivnet..."
    downloadStemcell $STEMCELL_VERSION
  else
    logInfo "stemcell ${STEMCELL_VERSION} already downloaded to: '${SC_FILE_PATH}'"
  fi
else
  logError "No stemcell version could be extracted from product file '${PRODUCT_FILE}'"
  exit 1
fi