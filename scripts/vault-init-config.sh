# Copyright 2022 Shantanoo "Shan" Desai <shantanoo.desai@gmail.com>

#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at

#      http://www.apache.org/licenses/LICENSE-2.0

#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

# Script to create the Vault Local Configuration file for local file-system storage

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
