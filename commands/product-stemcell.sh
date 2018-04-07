#!/bin/bash

# Usage: pcfup product-stemcell <product.pivotal>
# Description: Return the stemcell version for a specific product pivotal file.

. $PCFUP_DIR/asserts/number-of-arguments.sh

. $PCFUP_DIR/methods/get-product-info.sh

assertNumberOfArguments 2 "pcfup product-stemcell <product.pivotal>"

getProductInfo $2
echo $STEMCELL_VERSION