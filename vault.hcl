disable_mlock = true

backend "file" {
    path="/data/vault"
}

listener "tcp" {
address = "0.0.0.0:8200"
}