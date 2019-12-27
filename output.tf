output "public_dns" {
  description = "The public DNS adress for the instance"
  value       = concat(aws_instance.this.*.public_dns, [""])[0]

}

output "public_ip" {
  description = "The public IP address of the instance"
  value       = concat(aws_instance.this.*.public_ip, [""])[0]
}

output "private_dns" {
  description = "The private DNS adress for the instance"
  value       = concat(aws_instance.this.*.private_dns, [""])[0]
}

output "private_ip" {
  description = "The private IP address of the instance"
  value       = concat(aws_instance.this.*.private_ip, [""])[0]
}