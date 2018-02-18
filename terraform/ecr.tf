resource "aws_ecr_repository" "myapp" {
  name = "myapp"
}

output "myapp-repo" {
  value = "${aws_ecr_repository.myapp.repository_url}"
}
