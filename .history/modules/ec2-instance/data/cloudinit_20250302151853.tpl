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
  - bash -c 'timeout=45; interval=5; waited=0; while ! systemctl is-active --quiet docker; do sleep $interval; waited=$((waited + interval)); if [ $waited -ge $timeout ]; then echo "ERROR: docker service did not become active within ${timeout} seconds"; exit 1; fi; done'
