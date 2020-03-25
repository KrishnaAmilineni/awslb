resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection

  tags = var.tags
}

resource "aws_lb_listener" "this" {
  count             = length(var.listner_configuration)
  load_balancer_arn = aws_lb.this.arn
  port              = lookup(var.listner_configuration[count.index], "port")
  protocol          = lookup(var.listner_configuration[count.index], "protocol")

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[count.index].arn
  }
}

resource "aws_lb_target_group" "this" {
  count    = length(var.listner_configuration)
  name     = lower("${lookup(var.listner_configuration[count.index], "type")}-tg")
  port     = lookup(var.listner_configuration[count.index], "port")
  protocol = lookup(var.listner_configuration[count.index], "protocol")
  vpc_id   = var.vpc_id
  tags     = var.tags

  depends_on = [
    aws_lb.this
  ]
}

resource "aws_lb_target_group_attachment" "this" {
  count            = length(var.targets)
  target_group_arn = aws_lb_target_group.this[lookup(var.targets[count.index], "target_index")].arn
  target_id        = lookup(var.targets[count.index], "instanceId")
  port             = lookup(var.targets[count.index], "port")
}

data "aws_route53_zone" "zone" {
  count        = var.zone_name == "" ? 0 : 1
  name         = "${var.zone_name}."
  private_zone = true
}

resource "aws_route53_record" "lb_base_alias" {
  count   = var.zone_name == "" ? 0 : 1
  zone_id = data.aws_route53_zone.zone[0].zone_id
  name    = "${var.name}.${data.aws_route53_zone.zone[0].name}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.this.dns_name]
}

resource "aws_route53_record" "lb_alias" {
  count   = length(var.alias)
  zone_id = data.aws_route53_zone.zone[0].zone_id
  name    = "${var.alias[count.index]}.${data.aws_route53_zone.zone[0].name}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.this.dns_name]
}


resource "aws_cloudwatch_metric_alarm" "nlbtg_health" {
  count                     = var.create_alarm ? length(aws_lb_target_group.this) : 0
  alarm_name                = "${var.name}-${aws_lb_target_group.this[count.index].name}-unhealthy-count"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "UnHealthyHostCount"
  namespace                 = "AWS/NetworkELB"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  treat_missing_data        = "ignore"
  alarm_description         = "NLB ${var.name}-${aws_lb_target_group.this[count.index].name}-unhealthy-count"
  insufficient_data_actions = []

  dimensions = {
    LoadBalancer = aws_lb.this.arn_suffix
    TargetGroup  = aws_lb_target_group.this[count.index].arn_suffix
  }

  alarm_actions = [
    local.alarm_sns
  ]
}
