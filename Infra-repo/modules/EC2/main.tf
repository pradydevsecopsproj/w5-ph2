
# # ---------------------------------------------------------
# # Existing VPC
# # ---------------------------------------------------------

# data "aws_vpc" "existing" {
#   id = var.vpc_id
# }

# # ---------------------------------------------------------
# # Existing subnet
# # ---------------------------------------------------------

# data "aws_subnet" "existing" {
#   id = var.subnet_id
# }

# # ---------------------------------------------------------
# # Ubuntu 22.04 LTS AMI
# # ---------------------------------------------------------

# data "aws_ssm_parameter" "ubuntu_2204" {
#   name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
# }

# # ---------------------------------------------------------
# # Security Group
# # ---------------------------------------------------------

# resource "aws_security_group" "ec2" {
#   name        = "${var.environment}-ec2-sg"
#   description = "Security group for Ubuntu EC2 instance"
#   vpc_id      = data.aws_vpc.existing.id

#   # SSH
#   ingress {
#     description = "SSH access"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"

#     # IMPORTANT:
#     # Replace with your public IP /32.
#     cidr_blocks = [var.ssh_allowed_cidr]
#   }

#   # Outbound traffic
#   egress {
#     description = "Allow outbound IPv4 traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name        = "${var.environment}-ec2-sg"
#     Environment = var.environment
#     ManagedBy   = "Terraform"
#   }
# }

# ---------------------------------------------------------
# EC2 Instance
# ---------------------------------------------------------

resource "aws_instance" "app" {
  ami           = data.aws_ssm_parameter.ubuntu_2204.value
  instance_type = var.instance_type

  subnet_id = data.aws_subnet.existing.id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  key_name = var.key_name

  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume_size
    encrypted   = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = merge(local.common_tags, { Name = "${var.environment_name}-ec2-prady" })
}