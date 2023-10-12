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

# Secrets for wp-config salts
resource "aws_secretsmanager_secret" "auth_key" {
  name_prefix = "auth_key"
}

resource "aws_secretsmanager_secret_version" "auth_key" {
  secret_id     = aws_secretsmanager_secret.auth_key.id
  secret_string = data.aws_secretsmanager_random_password.auth_key.random_password
}

data "aws_secretsmanager_random_password" "auth_key" {
  password_length     = 55
  exclude_punctuation = true
}

# secure auth key
resource "aws_secretsmanager_secret" "secure_auth_key" {
  name_prefix = "secure_auth_key"
}

resource "aws_secretsmanager_secret_version" "secure_auth_key" {
  secret_id     = aws_secretsmanager_secret.secure_auth_key.id
  secret_string = data.aws_secretsmanager_random_password.secure_auth_key.random_password
}

data "aws_secretsmanager_random_password" "secure_auth_key" {
  password_length     = 55
  exclude_punctuation = true
}

# logged in key
resource "aws_secretsmanager_secret" "logged_in_key" {
  name_prefix = "logged_in_key"
}

resource "aws_secretsmanager_secret_version" "logged_in_key" {
  secret_id     = aws_secretsmanager_secret.logged_in_key.id
  secret_string = data.aws_secretsmanager_random_password.logged_in_key.random_password
}

data "aws_secretsmanager_random_password" "logged_in_key" {
  password_length     = 55
  exclude_punctuation = true
}

# nonce key
resource "aws_secretsmanager_secret" "nonce_key" {
  name_prefix = "nonce_key"
}

resource "aws_secretsmanager_secret_version" "nonce_key" {
  secret_id     = aws_secretsmanager_secret.nonce_key.id
  secret_string = data.aws_secretsmanager_random_password.nonce_key.random_password
}

data "aws_secretsmanager_random_password" "nonce_key" {
  password_length     = 55
  exclude_punctuation = true
}

# auth salt
resource "aws_secretsmanager_secret" "auth_salt" {
  name_prefix = "auth_salt"
}

resource "aws_secretsmanager_secret_version" "auth_salt" {
  secret_id     = aws_secretsmanager_secret.auth_salt.id
  secret_string = data.aws_secretsmanager_random_password.auth_salt.random_password
}

data "aws_secretsmanager_random_password" "auth_salt" {
  password_length     = 55
  exclude_punctuation = true
}

# secure_auth salt
resource "aws_secretsmanager_secret" "secure_auth_salt" {
  name_prefix = "secure_auth_salt"
}

resource "aws_secretsmanager_secret_version" "secure_auth_salt" {
  secret_id     = aws_secretsmanager_secret.secure_auth_salt.id
  secret_string = data.aws_secretsmanager_random_password.secure_auth_salt.random_password
}

data "aws_secretsmanager_random_password" "secure_auth_salt" {
  password_length     = 55
  exclude_punctuation = true
}

# logged_in_salt
resource "aws_secretsmanager_secret" "logged_in_salt" {
  name_prefix = "logged_in_salt"
}

resource "aws_secretsmanager_secret_version" "logged_in_salt" {
  secret_id     = aws_secretsmanager_secret.logged_in_salt.id
  secret_string = data.aws_secretsmanager_random_password.logged_in_salt.random_password
}

data "aws_secretsmanager_random_password" "logged_in_salt" {
  password_length     = 55
  exclude_punctuation = true
}

# nonce_salt
resource "aws_secretsmanager_secret" "nonce_salt" {
  name_prefix = "nonce_salt"
}

resource "aws_secretsmanager_secret_version" "nonce_salt" {
  secret_id     = aws_secretsmanager_secret.nonce_salt.id
  secret_string = data.aws_secretsmanager_random_password.nonce_salt.random_password
}

data "aws_secretsmanager_random_password" "nonce_salt" {
  password_length     = 55
  exclude_punctuation = true
}
