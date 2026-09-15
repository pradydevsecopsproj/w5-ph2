
output "ec2_id" {
  value       = aws_instance.app.id
  description = "The ID of the created EC2"
}


