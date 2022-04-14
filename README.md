# Configure Vault Server using Docker Init Container with Compose

Configure Vault Server using Docker Init Containers.

This repository is a Proof-of-Concept about Docker init Containers using Compose files.

## Usage

    docker compose up

should bring up the `vault-init` container first. This container creates a `config.hcl` file that uses the filesystem as storage.
Once this file is stored in the `/vault/config/` directory, we share it to the main `vault` container using shared volumes in our Compose
file, `vault-init-config`.

This shared volume is mounted to the `/vault/config` directory and the configuration is made available to Vault for startup.

Bring the stack down by also purging the shared volume:

    docker compose down --volumes

## Docker Init Container in Compose

> NOTE: this feature is similar to __Kubernetes Init Containers__, which is available for
> Docker Compose since version 1.29.

The Init Container can initialize your container by using the `depends_on` spec. Depending on the
intialization process, you can set three conditions of the container's state you wish to initialize:

- `service_started`
- `service_healthy`
- `service_completed_sucessfully`

Unfortunately, this feature is yet to be documented. However, some resources to look into:

1. [Feature Request Issue on Docker Compose ][2]
2. [Pending Pull-Request for Documentation of Init Containers][3]
3. [StackExchange Query with a _possible_ example][4]


## System Specs

Docker Engine version

```bash
Client:
 Version:           20.10.7
 API version:       1.41
 Go version:        go1.13.8
 Git commit:        20.10.7-0ubuntu5~20.04.2
 Built:             Mon Nov  1 00:34:17 2021
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Desktop
 Engine:
  Version:          20.10.13
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.15
  Git commit:       906f57f
  Built:            Thu Mar 10 14:06:05 2022
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.5.10
  GitCommit:        2a1d4dbdb2a1030dc5b01e96fb110a9d9f150ecc
 runc:
  Version:          1.0.3
  GitCommit:        v1.0.3-0-gf46b6ba
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

Docker Compose CLI Version (part of `docker` CLI)

```bash
Docker Compose version 2.3.3
```

[2]: https://github.com/docker/compose/issues/6855
[3]: https://github.com/docker/docker.github.io/issues/12633
[4]: https://stackoverflow.com/questions/70322031/does-docker-compose-support-init-container
