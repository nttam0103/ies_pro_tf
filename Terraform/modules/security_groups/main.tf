data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
} 
resource "aws_security_group" "bastion_nat_sg" {
  name        = "bastion-nat-sg"
  vpc_id      = var.vpc_id
  description = "Allow SSH access from my IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${trimspace(data.http.myip.response_body)}/32"]

 }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

 

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.bastion_nat_sg_id]

 }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.rds_post
    to_port         = var.rds_post
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_nat_sg_id]
  }

  ingress {
    from_port       = var.rds_post
    to_port         = var.rds_post
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}