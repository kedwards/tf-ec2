output "public_dns" {
  description = "The public DNS adress for the instance"
  value       = aws_instance.this[0].public_dns
}

output "public_ip" {
  description = "The public IP address of the instance"
  value       = aws_instance.this[0].public_ip
}

output "private_dns" {
  description = "The private DNS adress for the instance"
  value       = aws_instance.this[0].private_dns
}

output "private_ip" {
  description = "The private IP address of the instance"
  value       = aws_instance.this[0].private_ip
}