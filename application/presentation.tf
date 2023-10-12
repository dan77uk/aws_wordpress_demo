resource "aws_lb" "wordpress_alb" {
  name               = "LoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB_SG.id]
  subnets            = [for subnet in data.terraform_remote_state.network.outputs.public_subnets : subnet]
}

resource "aws_autoscaling_group" "wordpress-asg" {
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.wordpress_ec2.name
  vpc_zone_identifier  = data.terraform_remote_state.network.outputs.private_app_subnets[*]
  name                 = "WP_AutoScalingGroup"
}

resource "aws_lb_target_group" "private_application_tg" {
  name     = "EC2--Target-Group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc
}

resource "aws_autoscaling_attachment" "wordpress" {
  autoscaling_group_name = aws_autoscaling_group.wordpress-asg.id
  lb_target_group_arn    = aws_lb_target_group.private_application_tg.arn
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_application_tg.arn
  }
}
