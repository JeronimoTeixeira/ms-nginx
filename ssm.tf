data "aws_ssm_parameter" "ecs_ms" {
  name = "/ms/ecs/ecs_ms"
}

data "aws_ssm_parameter" "arn_nlb_ms" {
  name = "/ms/lb/arn_nlb_ms"
}

data "aws_ssm_parameter" "id_vpc_ms" {
  name = "/ms/vpc/id_vpc_ms"
}

data "aws_ssm_parameter" "id_sub_ms_a" {
  name = "/ms/vpc/id_sub_ms_a"
}

data "aws_ssm_parameter" "id_sub_ms_b" {
  name = "/ms/vpc/id_sub_ms_b"
}

data "aws_ssm_parameter" "repository_url" {
  name = "/ms/ecr/repository_url_ecr_ms"
}
