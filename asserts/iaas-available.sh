#!/bin/bash

function assertIaasAvailable() {
  test -v IAAS 2>>/dev/null >>/dev/null || (logError "failed to detect IaaS, please set environment variable \$IAAS or specify --iaas." ; exit 10)
}
