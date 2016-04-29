#!/bin/sh
set -ex
if [ "$VAULT_DEV" == "1" ] || [ "$VAULT_DEV" == "true" ]; then
    vault server -dev
else
    confd -backend env -onetime
    vault server -config /etc/vault.hcl -log-level ${VAULT_LOG_LEVEL:-info}
fi