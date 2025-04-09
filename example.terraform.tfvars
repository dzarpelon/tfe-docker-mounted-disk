# AWS variables setup
aws_region              = "<your-aws-region>"
aws_credentials_profile = "<your-aws-credentials-profile>"

# EC2 instance variables
aws_ami           = "<your-aws-ami-id>" # Example: ami-12345678
aws_instance_type = "<your-instance-type>" # Example: t3.medium

# Tags
aws_owner         = "<your-owner-name>" # Example: john.doe
aws_instance_name = "<your-instance-name>" # Example: my-tfe-instance
certbot_email     = "<your-email-address>" # Example: john.doe@example.com

tfe_version       = "<your-tfe-version>" # Example: v202503-1
disk_size         = <your-disk-size> # Example: 80

route53_zone_id   = "<your-route53-zone-id>" # Example: Z1234567890ABCDEF
route53_zone_name = "<your-route53-zone-name>" # Example: example.com

encryption_password = "<your-encryption-password>" 
initial_user_password = "<your-initial-user-password>" # must be at least 10 characters long