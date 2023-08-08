resource "aws_route_table" "tw_route_table" {
  vpc_id = var.aws_vpc_id

  tags = {
    Name = var.private_rt_table_name
  }
}
resource "aws_route_table_association" "tw_route_table_association" {
  subnet_id      = var.aws_subnet_ids[1]
  route_table_id = aws_route_table.tw_route_table.id
}
