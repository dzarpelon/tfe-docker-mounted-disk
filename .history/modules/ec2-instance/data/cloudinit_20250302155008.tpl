#cloud-config
package_update: true
package_upgrade: false
apt:
  sources:
    docker.list:
      source: deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable
      keyid: 9DC858229FC7DD38854AE2D88D81803C0EBFCD88

packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - gnupg-agent
  - software-properties-common
  - docker-compose
  - docker-ce-cli
  - containerd.io
  - docker-ce

# create the docker group
groups:
  - docker

# Add default auto created user to docker group
system_info:
  default_user:
    groups: [docker]

# refresh groups
runcmd:
  - newgrp docker
  - systemctl enable docker # ensure docker service is enabled at startup
  - systemctl start docker # start docker service immediately
