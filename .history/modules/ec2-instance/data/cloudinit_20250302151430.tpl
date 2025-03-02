#cloud-config
package_update: true
package_upgrade: true
packages:
  - docker.io
runcmd:
  - apt-get update
  - apt-get install -y docker-compose
  - usermod -aG docker ubuntu
  - newgrp docker
  - systemctl start docker
  - systemctl enable docker
