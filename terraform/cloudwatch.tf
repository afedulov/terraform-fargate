resource "aws_cloudwatch_log_group" "myapp" {
  name              = "/ecs/${var.APP_NAME}"
  retention_in_days = 30
  tags {
    Name = "${var.APP_NAME}"
  }
}
