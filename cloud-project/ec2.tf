data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"] # Official Amazon images

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# This creates the EC2 instance (the server)
resource "aws_instance" "honeypot" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  # This attaches the firewall we made on Day 2!
  vpc_security_group_ids = [aws_security_group.honeypot_sg.id]

  tags = {
    Name    = "Honeypot-Server"
    Project = "aws-honeypot-alerting"
  }
}

# This will show us the server's public IP address after it's created
output "honeypot_public_ip" {
  value       = aws_instance.honeypot.public_ip
  description = "Public IP address of the honeypot EC2 instance."
}