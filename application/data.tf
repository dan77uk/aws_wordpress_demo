data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "wordpress-tutorial-state-store"
    key    = "network/terraform.tfstate"
    region = "eu-west-1"
  }
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
