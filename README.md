## Images
|Tag|Versions|
|---|---|
|`latest`| Vault:`0.5.2` Confd `0.11.0`|
|`0.5.2`| Vault:`0.5.2` Confd `0.11.0`| 

## Usage
This image runs [confd](https://github.com/kelseyhightower/confd) once against the environment to create a config file, then starts up Vault.

Vault options are set via environment variables. Options are generally in the format `VAULT_THING_SUBTHING`, so the listener's TCP address that would normally go into a config file as

```hcl
listener "tcp" {
  address = "0.0.0.0:8200"
}
```

becomes `VAULT_LISTENER_ADDRESS` in the environment. The bare minimum options to are set by default (`VAULT_BACKEND=inmem`, `VAULT_LISTENER_ADDRESS=0.0.0.0:8200`, and `VAULT_LISTENER_TLS_DISABLE=1`), but these can be overridden at runtime.

The exception is `VAULT_DEV`. If this is set to `1`, Vault will be started in dev mode and all other options will be ignored.

_All_ the options can be set this way. Seriously. See [`confd/templates/vault.hcl.tmpl`](https://github.com/colebrumley/docker-vault/blob/master/confd/templates/vault.hcl.tmpl) for a list.
