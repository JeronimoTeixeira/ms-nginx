variable "ms_name" {
  description = "Nome do Microserviço"
  type = string
  default = "nginx"
}

variable "default_port" {
  description = "Porta utilizada para ingress port, health check e target group"
  type = number
  default = 80
}

variable "default_protocol" {
  description = "Protocolo para ingresso"
  type        = string
  default     = "TCP"
}

variable "ingress_cidr_blocks" {
  description = "Lista de blocos CIDR permitidos para ingresso"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_from_port" {
  description = "Porta de origem para egresso"
  type        = number
  default     = 0
}

variable "egress_to_port" {
  description = "Porta de destino para egresso"
  type        = number
  default     = 0
}

variable "egress_protocol" {
  description = "Protocolo para egresso"
  type        = string
  default     = "-1"
}

variable "egress_cidr_blocks" {
  description = "Lista de blocos CIDR permitidos para egresso"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "task_network_mode" {
  description = "Modo de rede da task"
  type        = string
  default     = "awsvpc"
}

variable "task_requires_compatibilities" {
  description = "Compatibilidades requeridas para a task"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "task_cpu" {
  description = "CPU para a task"
  type        = string
  default     = "256"
}

variable "task_memory" {
  description = "Memória para a task"
  type        = string
  default     = "512"
}

variable "task_container_image" {
  description = "Imagem do container"
  type        = string
}

variable "task_container_memory" {
  description = "Memória do container"
  type        = number
  default     = 128
}

variable "task_container_cpu" {
  description = "CPU do container"
  type        = number
  default     = 128
}

variable "service_desired_count" {
  description = "Desired Count para service"
  type        = number
  default     = 1
}

variable "service_launch_type" {
  description = "Lauch type para a service"
  type        = string
  default     = "FARGATE"
}

variable "health_check_enabled" {
  description = "Indica se o health check está habilitado"
  type        = bool
  default     = true
}

variable "health_check_interval" {
  description = "Intervalo entre as verificações de saúde (em segundos)"
  type        = number
  default     = 30
}

variable "health_check_port" {
  description = "Porta para o health check"
  type        = number
  default     = var.default_port
}

variable "health_check_protocol" {
  description = "Protocolo para o health check"
  type        = string
  default     = var.default_protocol
}

variable "health_check_timeout" {
  description = "Tempo limite para o health check (em segundos)"
  type        = number
  default     = 10
}

variable "health_check_healthy_threshold" {
  description = "Número de verificações consecutivas bem-sucedidas necessárias para considerar a instância como saudável"
  type        = number
  default     = 3
}

variable "health_check_unhealthy_threshold" {
  description = "Número de verificações consecutivas malsucedidas necessárias para considerar a instância como não saudável"
  type        = number
  default     = 3
}

