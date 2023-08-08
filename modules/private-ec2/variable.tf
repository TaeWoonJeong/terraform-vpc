variable "private_ec2_instance_type" {
  description = "private ec2 인스턴스 타입입니다."
  default     = "t2.micro"
}

variable "private_ec2_name" {
  description = "private ec2 name 태그 입니다."
  default     = "my-private-ec2"
}