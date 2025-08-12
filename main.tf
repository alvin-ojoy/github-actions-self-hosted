provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "github-actions" {
  name = "allow-http-https"
  description = "allow http traffic"
  vpc_id = "vpc-01cb8f26a7fed46f0"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "github" {
  ami = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.github-actions.id]
  key_name = aws_key_pair.deployer.key_name

  tags = {
    Name = "github-actions"
  }
}

