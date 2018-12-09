resource "aws_ecs_cluster" "fargate" {
  name = "${var.APP_NAME}"
}
