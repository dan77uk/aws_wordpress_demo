terraform {
  backend "s3" {
    bucket = "wordpress-tutorial-state-store"
    key    = "network/terraform.tfstate"
    region = "eu-west-1"
  }
}
