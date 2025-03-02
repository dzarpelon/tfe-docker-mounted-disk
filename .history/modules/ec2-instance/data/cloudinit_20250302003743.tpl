#cloud-config
package_update: true

packages:
  - docker.io
  - docker-compose
runcmd:
  - systemctl enable docker
  - systemctl start docker
groups:
  - docker
system_info:
  default_user:
    groups: [docker]
