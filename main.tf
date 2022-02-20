resource "aws_key_pair" "displayr_key_pair" {
  key_name   = "displayr_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAkvojeZQx9RLiFNkQz/f+l/SMkNoEB+btrP8cL9+LlAewwOiRpbytCDAVoMGGJk3IZ/wbHwplO5nS179F47O2gDMehFyoGaSJEiBI5xUJNB0oHbqrYGxCpkzUNKnkFxtbFcw5R0tkDmUbib4dgvJzY834u7F6FnJbLVCdTlpq3b4Xqk0hmoCOpAtKGtef0HiXBIzT4Otp8I4xJZn1297AfsRaQMQ4YWY3E04srLy8756cT0VZgWOdbX9NwXbC/uTRFzaoScAtrt78cGo+biggEIuzJIhd3nh3SfTGp4vupDEdmNDaflWSJnwGEP0jGO0jol4ylRK8MfolZPlVjt1FGQ== rsa-key-20220220"

  tags = {
    Name = "displayr_asoni-kp"
  }
}

resource "aws_instance" "displayr_ec2" {
  ami                         = "ami-0567f647e75c7bc05"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.displayr_key_pair.key_name
  subnet_id                   = aws_subnet.displayr_subnet_1.id

  user_data = "${file("user_script.sh")}"

  tags = {
    Name = "displayr_asoni-ec2"
  }
}