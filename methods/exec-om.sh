#!/bin/bash

. $PCFUP_DIR/methods/log.sh

function execOM() {
  logDebug "execute om $@"
  om -t $OM_TARGET --username=$OM_USERNAME --password=$OM_PASSWORD --skip-ssl-validation $@
}