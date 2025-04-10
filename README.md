# tfe-docker-mounted-disk

## Description

This repository intends to have an automated installation of Terraform Enteprise using Docker with a mounted disk for its data.

Also, we automatically create the first admin user.

Please note that the deployment of Docker, creation of certificates and the TFE deploy - as well as its first user - happen on a cloudinit file, so please allow some time after the `terraform apply` command finishes before trying to use the system.

Deployment can be checked on the `/var/logs/cloud-init-output.log` file within the EC2 instance.

This system is tested on Ubuntu and the cloudinit file is created specifically for it, other distros are NOT supported and will not work.

The system was tested on Ubuntu 24.04, please make sure you test it before on other versions if you need to use them.

## Pre-requisites

> Some of the pre-requisites are specific to internal Hashicorp tooling to comply with security policies.

- Valid AWS account - [How to create an AWS account](https://aws.amazon.com/resources/create-account/)
- AWS CLI - [Installing AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- AWS credentials set using [AWS Config](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html) by default we use the "default" profile created under `~/.aws/credentials` by AWS config
- [Doormat CLI](https://docs.prod.secops.hashicorp.services/doormat/cli/) Installed
- [Terraform CLI installed](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- A [Route53 domain](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html) for the external DNS of the system.
- The AMI value that will be used for the system. Check [Canonical AMI locator](https://cloud-images.ubuntu.com/locator/ec2/) to find yours. Default here is 24.04 LTS.
- A valid Terraform Enterprise FDO license

## How to use

To use this project we have a few steps that need to be done before applying the configuration.

Here are those:

1. Login to Doormat using the cli:
   `doormat login -f`
2. Set the AWS credentials profile with the latest creadentials from Doormat:
   `doormat aws cred-file add-profile --account <your_aws_account_from_doormat> --set-default` this will set the `~/.aws/credentials` file with the proper credentials for your AWS environment.
3. Clone this repository to your system.
4. After cloning the repo, go to the base folder of it and initiatialize the project by running `terraform init`, this will download the necessary plugins and prepare the environment for the Terraform commands.

With the above done we should be good to define the needed variables and then apply the deployment.

On this repository we have a [example.terraform.tfvars](./example.terraform.tfvars) file with example values.

To use it, copy it to the same location and name the cpied file `terraform.tfvars`, then populate the file with your values.

Once your file tfvars file is set, you can run a `terraform plan` to check if it works with the desired outcome.

If that works well, run a `terraform apply`.

Once the apply finishes, the EC2 instance will be configured using Cloudinit. This is running in the background but you can check the logs for it.

To do that we can proceed as follows:

1. Login to the EC2 instance using the SSM authentication:

   ```bash
   doormat session --account <your_aws_account> --region <desired_region>
   ```

2. Become root with `sudo -i`
3. Check the output of the file `/var/log/cloud-init-output.log` you should see something like this:

   ```
   0c40145c7391: Pull complete
   0214f11f12cc: Pull complete
   cd74d088e6a7: Pull complete
   e1c8e1231fe8: Pull complete
   Digest: sha256:65b3dee33d08a3124979ec75b02bffe44c8936014316299fd62875df0965229a
   Status: Downloaded newer image for images.releases.hashicorp.com/hashicorp/terraform-enterprise:v202503-1
   images.releases.hashicorp.com/hashicorp/terraform-enterprise:v202503-1
   Saving debug log to /var/log/letsencrypt/letsencrypt.log
   Account registered.
   Requesting a certificate for tfe-fdo-docker-mounted-disk.diego-zarpelon.sbx.hashidemos.io

   Successfully received certificate.
   Certificate is saved at: /etc/letsencrypt/live/tfe-fdo-docker-mounted-disk.diego-zarpelon.sbx.hashidemos.io/fullchain.pem
   Key is saved at:         /etc/letsencrypt/live/tfe-fdo-docker-mounted-disk.diego-zarpelon.sbx.hashidemos.io/privkey.pem
   This certificate expires on 2025-07-08.
   These files will be updated when the certificate renews.
   Certbot has set up a scheduled task to automatically renew this certificate in the background.

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   If you like Certbot, please consider supporting our work by:
    * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
    * Donating to EFF:                    https://eff.org/donate-le
   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Created symlink /etc/systemd/system/multi-user.target.wants/tfe-enterprise.service → /etc/systemd/system/tfe-enterprise.service.
   Waiting for Terraform Enterprise container to start...
   TFE is not available yet at https://tfe-fdo-docker-mounted-disk.diego-zarpelon.sbx.hashidemos.io/admin. Please wait...
   TFE is not available yet at https://tfe-fdo-docker-mounted-disk.diego-zarpelon.sbx.hashidemos.io/admin. Please wait...
   TFE is not available yet at https://tfe-fdo-docker-mounted-disk.diego-zarpelon.sbx.hashidemos.io/admin. Please wait...
   HTTP/1.1 301 Moved Permanently
   TFE is up and running at https://tfe-fdo-docker-mounted-disk.diego-zarpelon.sbx.hashidemos.io/admin
   Will continue in 1 minute with the final steps
   Cloud-init v. 24.4-0ubuntu1~24.04.2 finished at Wed, 09 Apr 2025 18:04:45 +0000. Datasource DataSourceEc2Local.  Up 445.47 seconds
   ```

## Components

This system is modularized so it ensures that the code here can be easily read and used for other similar projects in future.

Here are the components of the system:

- A security group that opens ports 80 and 443 for inbound and outbound communication.
- The SSM (AWS Systems Management) module for a secure remote connection to the system. Check more info on how this works on [What is AWS Systems Manager?](https://docs.aws.amazon.com/systems-manager/latest/userguide/what-is-systems-manager.html)
- The EC2 instance, this is an Ubuntu system.
- The Route53 module creates the A record for our instance, we do need to have the domain pre-criated for it to work properly.
- Finaly, the cloudinit module has the installation of Docker, Docker-compose, the SSL certificates creation for TFE and then installs TFE and create the admin user.
