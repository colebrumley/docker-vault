#!/bin/sh
set -ex
confd -backend env -onetime
vault server -config /etc/vault.hcl -log-level ${VAULT_LOG_LEVEL:-info}