data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "tw_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.private_ec2_instance_type
  key_name                    = var.aws_key_name
  associate_public_ip_address = false
  subnet_id                   = var.aws_subnet_ids[1]
  vpc_security_group_ids      = [var.aws_sg_id]

  tags = {
    Name = var.private_ec2_name
  }
}