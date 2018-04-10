#!/bin/bash

# Usage: pcfup product <product> <version>
# Description: Download a product from Pivotal Network and install it to the Operations Manager, including the necessary stemcell.

. $PCFUP_DIR/asserts/pivnet-available.sh
. $PCFUP_DIR/asserts/om-available.sh
. $PCFUP_DIR/asserts/pivnet-signed-in.sh
. $PCFUP_DIR/asserts/om-signed-in.sh
. $PCFUP_DIR/asserts/iaas-available.sh
. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/log.sh
. $PCFUP_DIR/methods/exec-om.sh
. $PCFUP_DIR/methods/exec-pivnet.sh
. $PCFUP_DIR/methods/ensure-stemcell-is-available.sh
. $PCFUP_DIR/methods/get-product-info.sh

assertPivnetAvailable
assertOmAvailable
assertPivnetSignedIn
assertOmSignedIn
assertIaasAvailable
assertNumberOfArguments 3 "pcfup product <product> <version>"

PRODUCT=$2
VERSION=$3
PRODUCT_DOWNLOAD_FOLDER=$DOWNLOADS_FOLDER/$PRODUCT/$VERSION

mkdir -p $PRODUCT_DOWNLOAD_FOLDER
if [[ $(ls -1 $PRODUCT_DOWNLOAD_FOLDER/*.pivotal || echo "1") == "1" ]]; then
  logInfo "download $PRODUCT ($VERSION) from pivnet..."
  execPivnet download-product-files -p $PRODUCT -r $VERSION -d $PRODUCT_DOWNLOAD_FOLDER --glob=*.pivotal --accept-eula
else
  logInfo "use cached version from $PRODUCT_DOWNLOAD_FOLDER"
fi

PRODUCT_FILE=$(ls -1 $PRODUCT_DOWNLOAD_FOLDER/$PRODUCT*.pivotal 2>> /dev/null | head -1)
if [[ "$PRODUCT_FILE" == "" ]]; then
  PRODUCT_FILE=$(ls -1 $PRODUCT_DOWNLOAD_FOLDER/*.pivotal | head -1)
fi
logDebug "parse $PRODUCT_FILE to determine the necessary stemcell version."

getProductInfo $PRODUCT_FILE

if [ -n "$STEMCELL_VERSION" ]; then
  ensureStemcellIsAvailable $STEMCELL_VERSION
fi

logInfo "upload product $PRODUCT to OpsManager."
execOM upload-product --product $PRODUCT_FILE

logInfo "stage product $PRODUCT."
execOM stage-product -p $PRODUCT_NAME -v $VERSION