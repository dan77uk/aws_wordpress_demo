# load balancer security group
resource "aws_security_group" "ALB_SG" {
  name = "Load-Balancer-SG"
  tags = {
    Name = "Load-Balancer-SG"
  }
  vpc_id = data.terraform_remote_state.network.outputs.vpc
}

resource "aws_security_group_rule" "alb_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ALB_SG.id
}

resource "aws_security_group_rule" "alb_egress" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ALB_SG.id
  source_security_group_id = aws_security_group.EC2_SG.id
}

# EC2/WordPress App Security Group
resource "aws_security_group" "EC2_SG" {
  name = "EC2-SG"
  tags = {
    Name = "EC2-SG"
  }
  vpc_id = data.terraform_remote_state.network.outputs.vpc
}

resource "aws_security_group_rule" "ec2_ingress" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.EC2_SG.id
  source_security_group_id = aws_security_group.ALB_SG.id
}

resource "aws_security_group_rule" "ec2_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.EC2_SG.id
}

# RDS/Database Security Group
resource "aws_security_group" "RDS_SG" {
  name = "RDS_SG"
  tags = {
    Name = "RDS_SG"
  }
  vpc_id = data.terraform_remote_state.network.outputs.vpc
}

resource "aws_security_group_rule" "rds_ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.RDS_SG.id
  source_security_group_id = aws_security_group.EC2_SG.id
}
