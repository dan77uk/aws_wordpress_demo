resource "aws_db_instance" "default" {
  allocated_storage      = 20
  max_allocated_storage  = 100
  db_name                = "wordpress_db"
  engine                 = "mysql"
  engine_version         = "8.0.33"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = aws_secretsmanager_secret_version.db_pass.secret_string
  storage_type           = "gp2"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  identifier             = "wordpress-db"
  db_subnet_group_name   = data.terraform_remote_state.network.outputs.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.RDS_SG.id]
}
