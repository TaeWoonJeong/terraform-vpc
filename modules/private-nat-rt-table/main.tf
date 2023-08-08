resource "aws_route_table" "tw_route_table" {
  vpc_id = var.aws_vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.aws_nat_gateway_id
  }
  tags = {
    Name = var.private_nat_rt_table_name
  }
}
resource "aws_route_table_association" "tw_route_table_association" {
  subnet_id      = var.aws_subnet_ids[2]
  route_table_id = aws_route_table.tw_route_table.id
}
