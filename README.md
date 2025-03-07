# tfe-docker-mounted-disk

## Description

This repository is an automated installation of Terraform Enteprise using Docker with a mounted disk for its data.

## Pre-requisites

> Some of the pre-requisites are specific to internal Hashicorp tooling to comply with security policies.

- Valid AWS account - [How to create an AWS account](https://aws.amazon.com/resources/create-account/)
- AWS CLI - [Installing AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- AWS credentials set using [AWS Config](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html)
- [Doormat CLI](https://docs.prod.secops.hashicorp.services/doormat/cli/) Installed
- [Terraform CLI installed](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) - project was created using version 1.11.0
- The AMI that will be used for the system. Check [Canonical AMI locator](https://cloud-images.ubuntu.com/locator/ec2/) to find yours. Default here is 24.04 LTS.

## Components
