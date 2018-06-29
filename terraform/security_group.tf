resource "aws_security_group" "private" {
  name        = "allow_from_private_subnet"
  description = "Allow from private subnet"
  vpc_id      = "${aws_vpc.playground.id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["10.1.3.0/24", "10.1.4.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "public" {
  name        = "allow_from_public_subnet"
  description = "Allow from public subnet"
  vpc_id      = "${aws_vpc.playground.id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["10.1.1.0/24", "10.1.2.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
