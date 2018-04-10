#!/bin/bash

# Usage: pcfup pivotal-file-info <product.pivotal>
# Description: Return information about the pivotal file and the included product.

. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/get-product-info.sh

assertNumberOfArguments 2 "pcfup pivotal-file-info <product.pivotal>"

getProductInfo $2
echo "product: $PRODUCT_NAME"
echo "version: $PRODUCT_VERSION"
echo "stemcell: $STEMCELL_VERSION"
