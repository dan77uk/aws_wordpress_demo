resource "aws_secretsmanager_secret" "db_pass" {
  name_prefix = "db_password"
}

resource "aws_secretsmanager_secret_version" "db_pass" {
  secret_id     = aws_secretsmanager_secret.db_pass.id
  secret_string = data.aws_secretsmanager_random_password.db_pass.random_password
}

data "aws_secretsmanager_random_password" "db_pass" {
  password_length     = 30
  exclude_punctuation = true
}
