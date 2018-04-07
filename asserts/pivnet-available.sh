#!/bin/bash

function assertPivnetAvailable() {
  type pivnet 2>>/dev/null >>/dev/null || (logError "failed to find pivnet, please use 'pcfup download-tools' or install pivnet manually." ; exit 10)
}