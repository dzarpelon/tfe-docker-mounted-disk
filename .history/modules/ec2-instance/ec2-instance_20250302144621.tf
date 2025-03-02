# IAM Role for EC2 Instance to use SSM
resource "aws_iam_role" "ssm_role" {
  name = "${var.aws_instance_name}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach AWS Managed SSM Policy to the Role
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create an Instance Profile for EC2 to Assume the Role
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${var.aws_instance_name}-ssm-instance-profile"
  role = aws_iam_role.ssm_role.name
}


resource "aws_instance" "tfe-fdo-docker-mounted" {
  ami                    = var.aws_ami
  instance_type          = var.aws_instance_type
  iam_instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name
  //user_data              = file("${path.module}/data/cloudinit.tpl")

  tags = {
    Name  = var.aws_instance_name,
    owner = var.aws_owner
  }
}


