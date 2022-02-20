output "ec2-public-host-ip" {
  value = aws_instance.displayr_ec2.public_ip
}

output "ec2-user-username" {
  value = "ubuntu"
}

output "ec2-user-password" {
  value = "temp_password"
}
