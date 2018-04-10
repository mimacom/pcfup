#!/bin/bash

. $PCFUP_DIR/methods/log.sh

function getProductInfo() {
  PRODUCT_FILE=$1
  PRODUCT_METADATA=$(mktemp)
  unzip -p $PRODUCT_FILE 'metadata/*' > $PRODUCT_METADATA

  logDebug "meta data file is stored at $PRODUCT_METADATA"
  STEMCELL_VERSION=$(ruby -ryaml -e 'puts YAML.load(File.new("'$PRODUCT_METADATA'", "r"))["stemcell_criteria"]["version"]')
  PRODUCT_NAME=$(ruby -ryaml -e 'puts YAML.load(File.new("'$PRODUCT_METADATA'", "r"))["name"]')
  PRODUCT_VERSION=$(ruby -ryaml -e 'puts YAML.load(File.new("'$PRODUCT_METADATA'", "r"))["product_version"]')
  rm $PRODUCT_METADATA
  logDebug "detected $STEMCELL_VERSION in product, ensure that this version is available."
}