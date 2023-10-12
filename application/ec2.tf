resource "aws_launch_configuration" "wordpress_ec2" {
  depends_on    = [aws_db_instance.default]
  name_prefix   = "wordpress_ec2config"
  image_id      = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  security_groups = [
    aws_security_group.EC2_SG.id
  ]

  user_data = <<-EOF
  #!/bin/bash
  yum install -y httpd
  service httpd start
  wget https://wordpress.org/latest.tar.gz
  tar -xzf latest.tar.gz
  echo "
  <?php
  # define( 'DB_NAME', 'wordpress_db' );
  define( 'DB_NAME', '${aws_db_instance.default.db_name}' );
  define( 'DB_USER', 'admin' );
  define( 'DB_PASSWORD', '${aws_secretsmanager_secret_version.db_pass.secret_string}' );
  define( 'DB_HOST', '${aws_db_instance.default.address}' );
  define( 'DB_CHARSET', 'utf8' );
  define( 'DB_COLLATE', '' );

  define('AUTH_KEY',         '${aws_secretsmanager_secret_version.auth_key.secret_string}');
  define('SECURE_AUTH_KEY',  '${aws_secretsmanager_secret_version.secure_auth_key.secret_string}');
  define('LOGGED_IN_KEY',    '${aws_secretsmanager_secret_version.logged_in_key.secret_string}');
  define('NONCE_KEY',        '${aws_secretsmanager_secret_version.nonce_key.secret_string}');
  define('AUTH_SALT',        '${aws_secretsmanager_secret_version.auth_salt.secret_string}');
  define('SECURE_AUTH_SALT', '${aws_secretsmanager_secret_version.secure_auth_salt.secret_string}');
  define('LOGGED_IN_SALT',   '${aws_secretsmanager_secret_version.logged_in_salt.secret_string}');
  define('NONCE_SALT',       '${aws_secretsmanager_secret_version.nonce_salt.secret_string}');

  \$table_prefix = 'wp_';
  define( 'WP_DEBUG', false );

  if ( ! defined( 'ABSPATH' ) ) {
   define( 'ABSPATH', __DIR__ . '/' );
  }

  require_once ABSPATH . 'wp-settings.php';

  " > wordpress/wp-config.php 

  amazon-linux-extras install -y mariadb10.5 php8.2
  cp -r wordpress/* /var/www/html/
  service httpd restart
  EOF
}
