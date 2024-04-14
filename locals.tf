locals {
  ecs_ms_value      = data.aws_ssm_parameter.ecs_ms.value
  arn_nlb_ms_value  = data.aws_ssm_parameter.arn_nlb_ms.value
  id_vpc_ms_value   = data.aws_ssm_parameter.id_vpc_ms.value
  id_sub_ms_a_value = data.aws_ssm_parameter.id_sub_ms_a.value
  id_sub_ms_b_value = data.aws_ssm_parameter.id_sub_ms_b.value
  repository_url    = data.aws_ssm_parameter.arn_nlb_ms
}