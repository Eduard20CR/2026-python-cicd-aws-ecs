resource "aws_security_group" "alb" {
  name        = "${var.org_name}-${var.project_name}-${var.environment}-alb-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.org_name}-${var.project_name}-${var.environment}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = var.vpc_id
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = var.vpc_id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


resource "aws_security_group" "app" {
  name        = "${var.org_name}-${var.project_name}-${var.environment}-app-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.org_name}-${var.project_name}-${var.environment}-app-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_from_alb_http" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "app_from_alb_https" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
}
