locals {
  alarm_sns = var.alarm_sns == "" ? data.aws_ssm_parameter.sns.value : var.alarm_sns
}

data "aws_ssm_parameter" "sns" {
  name = "/clz/monitoring/sns"
}
