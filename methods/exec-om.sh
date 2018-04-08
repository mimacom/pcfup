#!/bin/bash

. $PCFUP_DIR/methods/log.sh

function execOM() {
  logDebug "execute om $@"
  type om 2>>/dev/null >>/dev/null \
    && om -t $OM_TARGET --username=$OM_USERNAME --password=$OM_PASSWORD --skip-ssl-validation $@ \
    || om-linux -t $OM_TARGET --username=$OM_USERNAME --password=$OM_PASSWORD --skip-ssl-validation $@
}