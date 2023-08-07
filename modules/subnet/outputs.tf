output "output_subnet_ids" {
    description = "만든 서브넷 3개를 내보냅니다."
    value = aws_subnet.tw_subnet[*].id
}