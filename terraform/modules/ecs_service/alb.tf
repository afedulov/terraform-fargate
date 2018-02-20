resource "aws_alb" "alb" {
  name = "${var.name}"
  internal = false

  #    "${aws_security_group.ecs.id}",
  security_groups = [
    "${split(",", var.alb_security_groups)}"
  ]

  subnets = [
    "${var.private_subnet}",
    "${var.public_subnet}"
  ]
}

resource "aws_alb_target_group" "tg" {
  name = "${var.name}"
  protocol = "HTTP"
  port = "3000"
  vpc_id = "${var.vpc_id}"
  target_type = "ip"

  health_check {
    path = "/"
  }
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.tg.arn}"
    type = "forward"
  }

  depends_on = ["aws_alb_target_group.tg"]
}


output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}
