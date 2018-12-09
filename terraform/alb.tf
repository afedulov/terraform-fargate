resource "aws_alb" "myapp" {
  name = "${var.APP_NAME}"
  internal = false

  security_groups = [
    "${aws_security_group.ecs.id}",
    "${aws_security_group.alb.id}",
  ]

  subnets = [
    "${module.base_vpc.public_subnets[0]}",
    "${module.base_vpc.public_subnets[1]}"
  ]
}

resource "aws_alb_target_group" "myapp" {
  name = "${var.APP_NAME}"
  protocol = "${var.TG_PROTO}"
  port = "${var.TG_LISTEN}"
  vpc_id = "${module.base_vpc.vpc_id}"
  target_type = "ip"

  health_check {
    path = "${var.TG_HEALTHCHECK}"
  }
}

resource "aws_alb_listener" "myapp" {
  load_balancer_arn = "${aws_alb.myapp.arn}"
  port = "${var.ALB_LISTEN}"
  protocol = "${var.ALB_PROTO}"

  default_action {
    target_group_arn = "${aws_alb_target_group.myapp.arn}"
    type = "forward"
  }

  depends_on = ["aws_alb_target_group.myapp"]
}


output "alb_dns_name" {
  value = "${aws_alb.myapp.dns_name}"
}
