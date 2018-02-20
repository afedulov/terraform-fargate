data "template_file" "template" {
  template = "${file("templates/ecs/${var.template}.json.tpl")}"
  vars {
    REPOSITORY_URL = "${aws_ecr_repository.ecr.repository_url}"
    AWS_REGION = "${var.aws_region}"
    LOGS_GROUP = "${aws_cloudwatch_log_group.log_group.name}"
    NAME = "${var.name}"
  }
}

resource "aws_ecs_task_definition" "task" {
  family                =  "${var.name}"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  container_definitions = "${data.template_file.template.rendered}"
  execution_role_arn = "${var.execution_role_arn}"
}

resource "aws_ecs_service" "service" {
  name = "${var.name}"
  cluster         = "${var.cluster_id}"
  launch_type     = "FARGATE"
  task_definition = "${aws_ecs_task_definition.task.arn}"
  desired_count   = 1

  network_configuration = {
    subnets = ["${var.private_subnet}"]
    security_groups = ["${split(",", var.ecs_security_groups)}"]
  }

  load_balancer {
   target_group_arn = "${aws_alb_target_group.tg.arn}"
   container_name = "${var.name}"
   container_port = 3000
  }

  depends_on = [
    "aws_alb_listener.listener"
  ]
}
