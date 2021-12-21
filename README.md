# terraform-eks## Requirements

| Name | Version |
|------|---------|
| aws | ~> 3.56.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| profile | The common profile for aws cli | `string` | `"default"` | no |
| region-common | The common region | `string` | `"eu-east-1"` | no |
| vpc\_cidr\_block | The IPv4 CIDR block of the common VPC | `string` | `"10.0.0.0/16"` | no |
| vpc\_name | The name of the common VPC | `string` | `"The common VPC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_arn | The Amazon Resource Name (ARN) of the cluster. |
| cluster\_id | The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready. |

