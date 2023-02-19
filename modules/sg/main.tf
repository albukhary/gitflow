resource "aws_security_group" "SG-Bastion" {
  vpc_id = var.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["84.54.78.148/32", "185.230.204.108/32"]
  }

  tags = {
    Name = "SG-Bastion"
  }
}

resource "aws_security_group" "SG-Public" {
  vpc_id = var.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-Public"
  }
}

resource "aws_security_group" "SG-Private" {
  vpc_id = var.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [var.vpc.cidr_block]
  }

  tags = {
    Name = "SG-Private"
  }
}

resource "aws_security_group" "SG-Database" {
  vpc_id = var.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [var.subnet_private.cidr_block]
  }

  tags = {
    Name = "SG-Database"
  }
}