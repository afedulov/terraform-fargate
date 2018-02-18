resource "aws_cloudwatch_log_group" "myapp" {
  name              = "/ecs/myapp"
  retention_in_days = 30
  tags {
    Name = "myapp"
  }
}
