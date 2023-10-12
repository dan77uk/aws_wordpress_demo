terraform {
  backend "s3" {
    bucket = "wordpress-tutorial-state-store"
    key    = "application/terraform.tfstate"
    region = "eu-west-1"
  }
}
