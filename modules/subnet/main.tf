resource "aws_subnet" "tw_subnet" {
  count = length(var.subnet_prefix)
  vpc_id     = var.aws_vpc_id
  cidr_block = element(var.subnet_cidr_blocks, count.index)
  availability_zone = var.subnet_availability_zone

  tags = {
    # name = "${var.subnet_prefix[count.index]}-subnet"
    Name = element([for v in var.subnet_prefix : "${v}-subnet"], count.index)
  }
}