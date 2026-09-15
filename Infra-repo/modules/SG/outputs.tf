
output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "The ID of the ALB SG"
}

output "app_sg_id" {
  value       = aws_security_group.app_sg.id
  description = "The ID of the application tier EC2 vm SG"
}

output "ssh_sg_id" {
  value       = aws_security_group.allow_ssh.id
  description = "The ID of the allow SSH SG"
}