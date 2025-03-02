#cloud-config
package_update: true
package_upgrade: true
packages:
  - ec2-instance-connect
  - docker.io
  - certbot
runcmd:
  - sudo apt-get update
  - sudo apt-get install -y docker-compose
  - sudo systemctl start docker
  - sudo systemctl enable docker
  - sudo usermod -aG docker ubuntu
  - newgrp docker << END
  - END
