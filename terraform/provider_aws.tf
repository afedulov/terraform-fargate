provider "aws" {
  region     = "${var.AWS_REGION}"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket = "${var.S3_BACKEND_BUCKET}"
    key    = "terraform-${var.ENV}.tfstate"
    region = "${var.AWS_REGION}"
  }
}
