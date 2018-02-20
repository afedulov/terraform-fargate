resource "aws_ecr_repository" "ecr" {
  name = "${var.name}"
}

output "service-repo" {
  value = "${aws_ecr_repository.ecr.repository_url}"
}
