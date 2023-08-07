variable "subnet_cidr_blocks" {
    description = "subnet을 3개 만들어준다."
    default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet_prefix" {
    description = "subnet 접두사입니다."
    default = ["my-public", "my-private", "my-db"]
}

variable "subnet_availability_zone" {
    description = "subnet 가용영역 입니다. t2.micro를 사용하기 위해 ap-northeast-2a 또는 2c를 사용해야합니다."
    default = "ap-northeast-2a"
}