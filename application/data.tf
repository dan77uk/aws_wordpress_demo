data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "wordpress-tutorial-state-store"
    key    = "network/terraform.tfstate"
    region = "eu-west-1"
  }
}
