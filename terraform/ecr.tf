resource "aws_ecr_repository" "myapp" {
  name = "${var.APP_NAME}"
}

output "myapp-repo" {
  value = "${aws_ecr_repository.myapp.repository_url}"
}
