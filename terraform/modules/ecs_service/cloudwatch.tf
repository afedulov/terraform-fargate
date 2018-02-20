resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${var.name}"
  retention_in_days = 30
  tags {
    Name = "${var.name}"
  }
}
