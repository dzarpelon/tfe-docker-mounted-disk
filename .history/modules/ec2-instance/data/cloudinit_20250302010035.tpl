#cloud-config
package_update: true

packages:
  - docker.io
  - docker-compose

groups:
  - docker
system_info:
  default_user:
    groups: [docker]
runcmd:
  - systemctl enable docker
  - systemctl start docker
