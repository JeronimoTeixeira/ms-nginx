terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  access_key = "test"
  secret_key = "test"
  skip_credentials_validation = true
  skip_metadata_api_check = true
  endpoints {
    ec2       = "http://localhost:4566"
    s3        = "http://localhost:4566"
    sts       = "http://localhost:4566"
    ecs       = "http://localhost:4566"
    elbv2     = "http://localhost:4566"
  }
}

resource "aws_security_group" "nginx_ms_sg" {
  name        = "${var.ms_name}-sg"
  description = "Security Group para o microserviço"

  vpc_id = local.id_vpc_ms_value

  ingress {
    from_port   = var.default_port
    to_port     = var.default_port
    protocol    = var.default_protocol
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }
}


resource "aws_ecs_task_definition" "nginx_ms" {
  family                   = "${var.ms_name}-tasks"
  network_mode             = var.task_network_mode
  requires_compatibilities = var.task_requires_compatibilities
  cpu                      = var.task_cpu
  memory                   = var.task_memory

  container_definitions = jsonencode([
    {
      name      = "${var.ms_name}-container",
      image     = "${locals.repository_url}:latest",
      memory    = var.task_container_memory,
      cpu       = var.task_container_cpu,
      portMappings = [
        {
          containerPort = var.default_port,
          hostPort      = var.default_port
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "nginx_ms" {
  name            = "${var.ms_name}-service"
  cluster         = aws_ecs_cluster.ecs_ms.id
  task_definition = aws_ecs_task_definition.nginx_ms.arn
  desired_count   = var.service_desired_count
  launch_type     = var.service_launch_type

  network_configuration {
    subnets         = [aws_subnet.sub_ms_a.id, aws_subnet.sub_ms_b.id]
    security_groups = [aws_security_group.nginx_ms_sg.id]
  }
}

resource "aws_lb_target_group" "nginx_ms_target_group" {
  name     = "${var.ms_name}-tg"
  port     = var.default_port
  protocol = var.default_protocol
  vpc_id   = aws_vpc.vpc_ms.id

  health_check {
    enabled             = var.health_check_enabled
    interval            = var.health_check_interval
    port                = var.default_port
    protocol            = var.default_protocol
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }
}

resource "aws_lb_target_group_attachment" "nginx_ms_attachment" {
  target_group_arn = aws_lb_target_group.nginx_ms_target_group.arn
  target_id        = aws_ecs_service.nginx_ms.id
  port             = var.default_port
}

resource "aws_lb_listener" "nlb_ms_listener" {
  load_balancer_arn = aws_lb.nlb_ms.arn
  port              = var.default_port
  protocol          = var.default_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_ms_target_group.arn
  }
}

