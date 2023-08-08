variable "aws_vpc_id" {
  type = string
}

variable "aws_subnet_ids" {
  type = list(any)
}

variable "aws_nat_gateway_id" {
  type = string
}