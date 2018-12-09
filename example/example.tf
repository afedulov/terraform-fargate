terraform {
  backend "s3" {
    bucket = "terraform-fargate"
    key    = "terraform-prod.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform_locks"
  }
}

module "test_app" {
  source = "../terraform"
  S3_BACKEND_BUCKET = "terraform-fargate"
  AWS_REGION = "us-west-2"
  APP_NAME = "test-app"
  ENV = "prod"
}
