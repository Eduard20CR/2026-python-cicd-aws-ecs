resource "aws_security_group" "alb" {
  name        = "${var.project_identifier}-alb-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_identifier}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_alb" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


resource "aws_security_group" "app" {
  name        = "${var.project_identifier}-app-sg"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_identifier}-app-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_from_alb_http" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 8000
  to_port     = 8000
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_app" {
  security_group_id = aws_security_group.app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
