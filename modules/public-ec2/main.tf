data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
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
  instance_type               = var.pubic_ec2_instance_type
  key_name                    = var.aws_key_name
  associate_public_ip_address = true
  subnet_id                   = var.aws_subnet_ids[0]
  vpc_security_group_ids      = [var.aws_sg_id]

  tags = {
    Name = var.public_ec2_name
  }
}

resource "aws_eip" "tw_eip" {
  instance = aws_instance.tw_instance.id
  domain = "vpc"
}

resource "aws_eip_association" "tw_eip_association" {
  instance_id   = aws_instance.tw_instance.id
  allocation_id = aws_eip.tw_eip.id
}

resource "null_resource" "configure-cat-app" {
  depends_on = [aws_eip_association.tw_eip_association]

  // triggers = {
  //   build_number = timestamp()
  // }

  # provisioner "file" {
  #   source      = "files/"
  #   destination = "/home/ubuntu/"

  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = tls_private_key.hashicat.private_key_pem
  #     host        = aws_eip.hashicat.public_ip
  #   }
  # }

  provisioner "remote-exec" {
    inline = [
      "sudo apt -y update",
      "sleep 15",
      "sudo apt -y update",
      "sudo apt -y install apache2",
      "sudo systemctl start apache2",
      "sudo chown -R ubuntu:ubuntu /var/www/html",
      "chmod +x *.sh",
      # "PLACEHOLDER=${var.placeholder} WIDTH=${var.width} HEIGHT=${var.height} PREFIX=${var.prefix} ./deploy_app.sh",
      "sudo apt -y install cowsay",
      "cowsay Mooooooooooo!",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.aws_private_pem
      host        = aws_eip.tw_eip.public_ip
    }
  }
}