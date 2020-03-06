## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| enable\_cross\_zone\_load\_balancing | Allows the LB to send requests to multiple AZ's based on availability. NLB only | `bool` | `true` | no |
| enable\_deletion\_protection | Toggle the deletion protection on the Load Balancer | `bool` | `false` | no |
| internal | Sets the LB to external or internal | `bool` | `true` | no |
| listner\_configuration | Load Balancer listener configuration | `list(map(any))` | `[]` | no |
| load\_balancer\_type | Whether it is an application or network load balancer | `string` | `"network"` | no |
| name | load balancer name | `string` | n/a | yes |
| security\_groups | IDs of security groups for Load Balancer | `list(string)` | `[]` | no |
| subnets | List of Subnet IDs for the Load Balancer | `list(string)` | n/a | yes |
| tags | Tags to be applied to resources | `map(any)` | `{}` | no |
| targets | Mapping of ec2 instance ids to target\_group indecies | `list(map(any))` | `[]` | no |
| vpc\_id | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| lb\_arn | n/a |
| lb\_dns\_name | n/a |
