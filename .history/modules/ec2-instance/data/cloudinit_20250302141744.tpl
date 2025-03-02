#cloud-config
package_update: true

packages:
  - amazon-ssm-agent

runcmd:
  - systemctl daemon-reload
  - systemctl enable amazon-ssm-agent
  - systemctl start amazon-ssm-agent
