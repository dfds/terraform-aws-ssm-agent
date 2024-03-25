output "instance_id" {
  value = aws_instance.this.id
}

output "connection_command" {
  value = local.connection_command
}