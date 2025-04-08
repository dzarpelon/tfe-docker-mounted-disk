#cloud-config
write_files:
  - path: /opt/tfe/docker-compose.yml
    permissions: "0644"
    content: |
      version: '3'
      services:
        tfe:
          image: "images.releases.hashicorp.com/hashicorp/terraform-enterprise:${tfe_version}"
          ports:
            - "80:80"
          environment:
            TFE_LICENSE: "${tfe_license}"
          volumes:
            - /var/opt/tfe:/var/opt/tfe
  - path: /etc/systemd/system/tfe-enterprise.service
    permissions: "0644"
    content: |
      [Unit]
      Description=Terraform Enterprise via Docker Compose
      Requires=docker.service
      After=docker.service

      [Service]
      WorkingDirectory=/opt/tfe
      ExecStartPre=/bin/bash -c "echo '${tfe_license}' | /usr/bin/docker login --username terraform images.releases.hashicorp.com --password-stdin"
      ExecStartPre=/usr/bin/docker pull images.releases.hashicorp.com/hashicorp/terraform-enterprise:${tfe_version}
      ExecStart=/usr/bin/docker compose -f /opt/tfe/docker-compose.yml up --detach
      ExecStop=/usr/bin/docker compose -f /opt/tfe/docker-compose.yml down
      Restart=always

      [Install]
      WantedBy=multi-user.target
runcmd:
  - apt-get update
  - apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  - apt-get update
  - apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
  - systemctl daemon-reload
  - systemctl enable docker
  - systemctl start docker
  - |
    while ! systemctl is-active --quiet docker; do
      echo "Waiting for Docker daemon to be up and running..."
      sleep 5
    done
  - echo "${tfe_license}" | docker login --username terraform images.releases.hashicorp.com --password-stdin
  - docker pull images.releases.hashicorp.com/hashicorp/terraform-enterprise:${tfe_version}
  - systemctl enable tfe-enterprise
  - systemctl start tfe-enterprise
