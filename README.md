## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| alarm\_sns | CW Alarm SNS | `string` | `""` | no |
| alias | Route53 alias | `list(string)` | `[]` | no |
| create\_alarm | Create CW Alarm | `bool` | `true` | no |
| enable\_deletion\_protection | Toggle the deletion protection on the Load Balancer | `bool` | `false` | no |
| internal | Sets the LB to external or internal | `bool` | n/a | yes |
| listner\_configuration | Load Balancer listener configuration | `list(map(any))` | `[]` | no |
| load\_balancer\_type | Whether it is an application or network load balancer | `string` | `"application"` | no |
| name | load balancer name | `string` | n/a | yes |
| security\_groups | IDs of security groups for Load Balancer | `list(string)` | `[]` | no |
| subnets | List of Subnet IDs for the Load Balancer | `list(string)` | n/a | yes |
| tags | Tags to be applied to resources | `map(any)` | `{}` | no |
| targets | Mapping of ec2 instance ids to target\_group indecies | `list(map(any))` | `[]` | no |
| vpc\_id | VPC ID | `string` | n/a | yes |
| zone\_name | Route53 Zone Name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| lb\_arn | n/a |
| lb\_dns\_name | n/a |
