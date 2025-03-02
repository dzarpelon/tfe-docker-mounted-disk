#cloud-config
package_update: true
packages:
  - ec2-instance-connect
  - docker.io
runcmd:
  - systemctl start docker
  - systemctl enable docker
