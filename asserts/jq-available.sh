#!/bin/bash

function assertJqAvailable() {
  type jq 2>>/dev/null >>/dev/null || (logError "failed to find jq, please use 'pcfup download-tools' or install jq manually." ; exit 10)
}
