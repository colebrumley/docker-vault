#!/bin/sh
set -ex
if [ "$VAULT_DEV" == "1" ] || [ "$VAULT_DEV" == "true" ]; then
    vault server -dev -dev-listen-address ${VAULT_DEV_LISTEN_ADDRESS:-0.0.0.0:8200}
else
    confd -backend env -onetime
    vault server -config /etc/vault.hcl -log-level ${VAULT_LOG_LEVEL:-info}
fi