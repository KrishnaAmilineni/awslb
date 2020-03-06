resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection       = var.enable_deletion_protection
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing

  tags = var.tags
}

resource "aws_lb_listener" "this" {
  count             = length(var.listner_configuration)
  load_balancer_arn = aws_lb.this.arn
  port              = lookup(var.listner_configuration[count.index], "port")
  protocol          = lookup(var.listner_configuration[count.index], "protocol")
  certificate_arn   = lookup(var.listner_configuration[count.index], "certificate_arn", "") != "" ? lookup(var.listner_configuration[count.index], "certificate_arn") : ""
  ssl_policy        = lookup(var.listner_configuration[count.index], "ssl_policy", "") != "" ? lookup(var.listner_configuration[count.index], "ssl_policy") : ""

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[count.index].arn
  }

}

resource "aws_lb_target_group" "this" {
  count                = length(var.listner_configuration)
  name                 = lower("${lookup(var.listner_configuration[count.index], "name")}")
  port                 = lookup(var.listner_configuration[count.index], "port")
  protocol             = lookup(var.listner_configuration[count.index], "protocol") == "TLS" ? "TCP" : lookup(var.listner_configuration[count.index], "protocol")
  vpc_id               = var.vpc_id
  deregistration_delay = 10

  depends_on = [
    aws_lb.this
  ]

  stickiness {
    enabled = false
    type    = "lb_cookie"
  }

  tags = var.tags
}

resource "aws_lb_target_group_attachment" "this" {
  count            = length(var.targets)
  target_group_arn = aws_lb_target_group.this[lookup(var.targets[count.index], "target_index")].arn
  target_id        = lookup(var.targets[count.index], "instanceId")
  port             = lookup(var.targets[count.index], "port")
}
