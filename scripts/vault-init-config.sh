#!/usr/bin/dumb-init /bin/sh
set -e

echo "Setting VAULT_LOCAL_CONFIG"

DEFAULT_VAULT_LOCAL_CONFIG='
listener "tcp" { 
              address = "vault:8200" 
              tls_disable = "1" 
              cluster_address = "vault:8201" 
          } 
          backend "file" {
              path = "/vault/file"
          } 
          default_lease_ttl = "168h" 
          max_lease_ttl = "720h"
'

VAULT_LOCAL_CONFIG=${VAULT_LOCAL_CONFIG:-$DEFAULT_VAULT_LOCAL_CONFIG}

export VAULT_LOCAL_CONFIG

echo "$(date) VAULT_LOCAL_CONFIG: ${VAULT_LOCAL_CONFIG}"

echo ${VAULT_LOCAL_CONFIG} > /vault/config/config.hcl
