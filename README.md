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

#### Examples

**Dev server**:

```bash
docker run -d --name vault -p 8200:8200 -e VAULT_DEV=1 elcolio/vault
docker logs vault
> ...
> Unseal Key: 53cfc41f4107152937a41067c4345c4776ed69a25244da83fc9bf7011439c350
> Root Token: cac1de2f-33e1-5f74-240c-dc84a465ebbd
> ...

export VAULT_ADDR=http://192.168.99.100:8200
export VAULT_TOKEN=cac1de2f-33e1-5f74-240c-dc84a465ebbd
vault write secret/key var=val
> Success! Data written to: secret/key

vault read secret/key
> Key           	Value
> lease_duration	2592000
> var           	val
```

**Consul-backed server**

Uses the [`docker-compose.yml`](https://github.com/colebrumley/docker-vault/blob/master/docker-compose.yml) file in the repo root dir.

```bash
docker-compose up -d
export VAULT_ADDR=(your_docker_host):8200
vault init

> Key 1: c1b7b9a8f44f9e645b0b9936e9d5b1cc67ffec30b8ebfb8299ff3a6af341641e01
> Key 2: 2dcd31f197a272d00049333a85f908b9919d735b8bd73e5d01a68cacb75477ab02
> Key 3: 40617b168aa30c167fc43e628c87b826f799961203cc4e3bc450bc987a6ec25603
> Key 4: c2ce2f9f1e187cff2916037bed81c08d519467cbabfab542fb37a8ff1752f7e104
> Key 5: af62657803190239569b0e23e4ff70123790828223e1c5243ec198cbda68421c05
> Initial Root Token: 0c3fe36f-3432-cb82-01bd-974d46ac3f87
>
> Vault initialized with 5 keys and a key threshold of 3. Please
> securely distribute the above keys. When the Vault is re-sealed,
> restarted, or stopped, you must provide at least 3 of these keys
> to unseal it again.
>
> Vault does not store the master key. Without at least 3 keys,
> your Vault will remain permanently sealed.
```
