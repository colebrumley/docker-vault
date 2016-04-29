FROM    alpine:3.2
ENV     VAULT_VERSION=0.5.2 \
        CONFD_VERSION=0.11.0 \
        VAULT_BACKEND=inmem \
        VAULT_LISTENER_ADDRESS=0.0.0.0:8200 \
        VAULT_LISTENER_TLS_DISABLE=1 \
        VAULT_DISABLE_MLOCK=true
RUN     apk add --update wget ca-certificates && \
        wget -O /tmp/vault.zip \
            https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_${VAULT_VERSION}_linux_amd64.zip && \
        wget -O /usr/bin/confd \
            https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 && \
        unzip -d /usr/bin/ /tmp/vault.zip && \
        chmod a+x /usr/bin/vault /usr/bin/confd && \
        rm -f /tmp/vault.zip && \
        rm -Rf /var/cache/apk/*
EXPOSE  8200
COPY    wrapper.sh /wrapper.sh
COPY    confd/ /etc/confd/
CMD     ["/wrapper.sh"]