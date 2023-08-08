output "output_nat_gw_id" {
  description = "nat gw id를 내보냅니다."
  value       = aws_nat_gateway.tw_nat_gateway.id
}