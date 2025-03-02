#cloud-config
package_update: true
package_upgrade: true
packages:
  - ec2-instance-connect
  - docker.io
  - certbot
runcmd:
  - apt-get update
  - apt-get install -y docker-compose
  - systemctl start docker
  - systemctl enable docker
  - usermod -aG docker ubuntu
  - newgrp docker << END
  - END
