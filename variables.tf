variable "service_name" {
  type        = string
  default     = "Desafio IAC"
  description = ""
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Default Region"
}

variable "instance_type" {
  type        = string
  default     = "t3.medium"
  description = "Instancia Default"
}

variable "key_pair_name" {
  type        = string
  default     = "vockey"
  description = "Chave"
}
