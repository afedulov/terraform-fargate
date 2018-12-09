data "aws_availability_zones" "available" {}

module "base_vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name = "${var.APP_NAME}"
  cidr = "${var.CIDR_VPC}"

  azs             = "${data.aws_availability_zones.available.names}"
  private_subnets = ["${split(",", var.CIDR_PRIVATE)}"]
  public_subnets  = ["${split(",", var.CIDR_PUBLIC)}"]

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

  tags = {
    Terraform = "true"
    Environment = "${var.ENV}"
  }
}
