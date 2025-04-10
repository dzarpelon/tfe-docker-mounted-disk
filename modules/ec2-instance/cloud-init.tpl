#cloud-config
write_files:
  - path: /opt/tfe/docker-compose.yml
    permissions: "0644"
    content: |
      version: '3.7'
      services:
        tfe:
          image: images.releases.hashicorp.com/hashicorp/terraform-enterprise:${tfe_version}
          environment:
            TFE_LICENSE: "${tfe_license}"
            TFE_HOSTNAME: "${aws_instance_name}.${route53_zone_name}"
            TFE_ENCRYPTION_PASSWORD: "${encryption_password}"
            TFE_OPERATIONAL_MODE: "disk"
            TFE_DISK_CACHE_VOLUME_NAME: "${aws_instance_name}_terraform-enterprise-cache"
            TFE_TLS_CERT_FILE: "/etc/ssl/private/terraform-enterprise/cert.pem"
            TFE_TLS_KEY_FILE: "/etc/ssl/private/terraform-enterprise/key.pem"
            TFE_TLS_CA_BUNDLE_FILE: "/etc/ssl/private/terraform-enterprise/bundle.pem"
            TFE_IACT_SUBNETS: "10.0.0.0/8,192.168.0.0/24"
          cap_add:
            - IPC_LOCK
          read_only: true
          tmpfs:
            - /tmp:mode=01777
            - /run
            - /var/log/terraform-enterprise
          ports:
            - "80:80"
            - "443:443"
          volumes:
            - type: bind
              source: /var/run/docker.sock
              target: /run/docker.sock
            - type: bind
              source: /etc/ssl/private/terraform-enterprise
              target: /etc/ssl/private/terraform-enterprise
            - type: bind
              source: /var/lib/terraform-enterprise
              target: /var/lib/terraform-enterprise
            - type: volume
              source: terraform-enterprise-cache
              target: /var/cache/tfe-task-worker/terraform
      volumes:
        terraform-enterprise-cache:
  - path: /etc/systemd/system/tfe-enterprise.service
    permissions: "0644"
    content: |
      [Unit]
      Description=Terraform Enterprise
      After=docker.service
      Requires=docker.service

      [Service]
      WorkingDirectory=/opt/tfe
      ExecStart=/usr/bin/docker-compose -f /opt/tfe/docker-compose.yml up -d
      ExecStop=/usr/bin/docker-compose -f /opt/tfe/docker-compose.yml down
      Restart=always
      RestartSec=10
      KillMode=process
      RemainAfterExit=yes
      StandardOutput=journal
      StandardError=journal

      [Install]
      WantedBy=multi-user.target

runcmd:
  - apt-get update
  - apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  - apt-get update
  - apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose certbot
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
  - certbot certonly --standalone --non-interactive --agree-tos --register-unsafely-without-email -d ${aws_instance_name}.${route53_zone_name}
  - mkdir -p /etc/ssl/private/terraform-enterprise
  - cp /etc/letsencrypt/live/${aws_instance_name}.${route53_zone_name}/cert.pem /etc/ssl/private/terraform-enterprise/cert.pem
  - cp /etc/letsencrypt/live/${aws_instance_name}.${route53_zone_name}/privkey.pem /etc/ssl/private/terraform-enterprise/key.pem
  - cp /etc/letsencrypt/live/${aws_instance_name}.${route53_zone_name}/fullchain.pem /etc/ssl/private/terraform-enterprise/bundle.pem
  - mkdir -p /mnt/terraform-enterprise
  - mkdir -p /opt/tfe/certs
  - mkdir -p /var/lib/terraform-enterprise
  - mkdir -p /etc/supervisor/conf.d
  - chmod -R 755 /etc/ssl/private/terraform-enterprise
  - chmod -R 755 /var/lib/terraform-enterprise
  - systemctl enable tfe-enterprise
  - systemctl start tfe-enterprise
  - |
    # Wait for the TFE container to be ready
    while ! docker ps | grep -q "hashicorp/terraform-enterprise"; do
      echo "Waiting for Terraform Enterprise container to start..."
      sleep 5
    done

    # Trying to connect to https://${aws_instance_name}.${route53_zone_name}/admin
    while true; do
        if curl -kI "https://${aws_instance_name}.${route53_zone_name}/admin" 2>&1 | grep -w "200\|301" ; then
            echo "TFE is up and running at https://${aws_instance_name}.${route53_zone_name}/admin"
            echo "Will continue in 1 minute with the final steps"
            sleep 60
            break
        else
            echo "TFE is not available yet at https://${aws_instance_name}.${route53_zone_name}/admin. Please wait..."
            sleep 60
        fi
    done

    # Dynamically retrieve the Initial Admin Creation Token (IACT) during runtime
    IACT_TOKEN=$(docker exec tfe_tfe_1 tfectl admin token)

    # Check if the token was retrieved successfully
    if [ -z "$IACT_TOKEN" ]; then
      echo "Failed to retrieve the Initial Admin Creation Token."
      exit 1
    fi

    # Create the initial admin user
    cat <<EOF > /opt/tfe/payload.json
    {
      "username": "admin",
      "password": "${initial_user_password}"
    }
    EOF

    CREATE_USER_RESPONSE=$(curl -k -s \
      --header "Content-Type: application/json" \
      --request POST \
      --data @/opt/tfe/payload.json \
      https://${aws_instance_name}.${route53_zone_name}/admin/initial-admin-user?token=$IACT_TOKEN)

    # Log the response from the admin user creation API for debugging
    echo "Admin user creation response: $CREATE_USER_RESPONSE" >> /var/log/cloud-init-debug.log

    # Extract the token from the response
    USER_TOKEN=$(echo "$CREATE_USER_RESPONSE" | jq -r '.token')

    # Check if the token was retrieved successfully
    if [ -z "$USER_TOKEN" ]; then
      echo "Failed to create the initial admin user. Response: $CREATE_USER_RESPONSE" >> /var/log/cloud-init-debug.log
      exit 1
    fi

    # Log the HTTP status code check for user creation
    echo "Checking user creation status with token: $USER_TOKEN" >> /var/log/cloud-init-debug.log
    USER_CHECK=$(curl -k -s -o /dev/null -w "%%{http_code}" \
      --header "Authorization: Bearer $USER_TOKEN" \
      https://${aws_instance_name}.${route53_zone_name}/api/v2/admin/users)

    echo "User creation HTTP status: $USER_CHECK" >> /var/log/cloud-init-debug.log

    if [ "$USER_CHECK" -eq "200" ]; then
      echo "Initial admin user created successfully." >> /var/log/cloud-init-debug.log
    else
      echo "Failed to create the initial admin user. HTTP status: $USER_CHECK" >> /var/log/cloud-init-debug.log
    fi
