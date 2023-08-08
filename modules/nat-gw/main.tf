resource "aws_eip" "tw_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "tw_nat_gateway" {
  allocation_id = aws_eip.tw_eip.id
  subnet_id     = var.aws_subnet_ids[0]

  tags = {
    Name = var.nat_gw_name
  }
}