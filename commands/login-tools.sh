#!/bin/bash

# UAA Admin
uaac token owner get $PCFUP_BOSH_UAA_ADMIN_ID $OM_USERNAME -s $PCFUP_BOSH_UAA_ADMIN_SECRET -p $OM_PASSWORD
