provider "aws" {
  region     = "${var.AWS_REGION}"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket = "${var.S3_BACKEND_BUCKET}"
    key    = "terraform${var.ENV}.tfstate"
    region = "${var.S3_BUCKET_REGION}"
  }
}


module "moduleapp" {
  source = "modules/ecs_service"
  vpc_id = "${module.base_vpc.vpc_id}"
  private_subnet = "${module.base_vpc.private_subnets[0]}"
  public_subnet = "${module.base_vpc.public_subnets[1]}"
  aws_region = "${var.AWS_REGION}"
  ecs_security_groups = "${aws_security_group.ecs.id}"
  alb_security_groups = "${aws_security_group.alb-myapp.id}"
  execution_role_arn = "${aws_iam_role.ecs_task_assume.arn}"
  name = "moduleapp"
  cluster_id = "${aws_ecs_cluster.fargate.id}"
  template = "myapp"
}
