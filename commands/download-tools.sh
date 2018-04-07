#!/bin/bash

# Usage: pcfup download-tools
# Description: Download tools which are necessary to run this application.

export DOWNLOAD_PATH_OM="https://github.com/pivotal-cf/om/releases/download/0.29.0/om-linux"
export DOWNLOAD_PATH_PIVNET="https://github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.49/pivnet-linux-amd64-0.0.49"
export DOWNLOAD_PATH_JQ="https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64"

. $PCFUP_DIR/methods/log.sh

mkdir -p ~/bin

set +e
type om 2>> /dev/null >> /dev/null
if [[ $? -eq 1 ]]; then
  logInfo "download om tool to ~/bin/om"
  wget -O$HOME/bin/om $DOWNLOAD_PATH_OM
  chmod +x ~/bin/om
else
  logDebug "do not need to download om, it's already there"
fi

type pivnet 2>> /dev/null >> /dev/null
if [[ $? -eq 1 ]]; then
  logInfo "download pivnet to ~/bin/pivnet"
  wget -O$HOME/bin/pivnet $DOWNLOAD_PATH_PIVNET
  chmod +x ~/bin/pivnet
else
  logDebug "do not need to download pivnet, it's already there"
fi

type jq 2>> /dev/null >> /dev/null
if [[ $? -eq 1 ]]; then
  logInfo "download jq tool to ~/bin/jq"
  wget -O$HOME/bin/jq $DOWNLOAD_PATH_JQ
  chmod +x ~/bin/jq
else
  logDebug "do not need to download jq, it's already there"
fi

logInfo "all tools are downloaded"
set -e