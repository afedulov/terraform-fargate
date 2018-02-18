data "template_file" "myapp" {
  template = "${file("templates/ecs/myapp.json.tpl")}"
  vars {
    REPOSITORY_URL = "${aws_ecr_repository.myapp.repository_url}"
    AWS_REGION = "${var.AWS_REGION}"
    LOGS_GROUP = "${aws_cloudwatch_log_group.myapp.name}"
  }
}

resource "aws_ecs_task_definition" "myapp" {
  family                = "myapp"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  container_definitions = "${data.template_file.myapp.rendered}"
  execution_role_arn = "${aws_iam_role.ecs_task_assume.arn}"
}

resource "aws_ecs_service" "myapp" {
  name            = "myapp"
  cluster         = "${aws_ecs_cluster.fargate.id}"
  launch_type     = "FARGATE"
  task_definition = "${aws_ecs_task_definition.myapp.arn}"
  desired_count   = 1

  network_configuration = {
    subnets = ["${module.base_vpc.private_subnets[0]}"]
    security_groups = ["${aws_security_group.ecs.id}"]
  }

  load_balancer {
   target_group_arn = "${aws_alb_target_group.myapp.arn}"
   container_name = "myapp"
   container_port = 3000
  }

  depends_on = [
    "aws_alb_listener.myapp"
  ]
}
