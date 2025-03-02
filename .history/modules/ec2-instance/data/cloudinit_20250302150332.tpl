#cloud-config
package_update: true
package_upgrade: true
packages:
  - docker.io
runcmd:
  - apt-get update
  - apt-get install -y docker-compose
  - systemctl start docker
  - systemctl enable docker
  - newgrp docker << END
  - END
  - usermod -aG docker ubuntu
