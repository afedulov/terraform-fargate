variable "S3_BACKEND_BUCKET" {
  default = "terraform-fargate" # ! REPLACE WITH YOUR TERRAFORM BACKEND BUCKET
}

variable "AWS_REGION" {
  type    = "string"
  default = "us-west-2"
}

variable "ENV" {
  default = "PROD"
}

variable "CIDR_VPC" {
  default = "10.0.0.0/16"
}

variable "CIDR_PRIVATE" {
  default = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
}

variable "CIDR_PUBLIC" {
  default = "10.0.101.0/24,10.0.102.0/24,10.0.103.0/24"
}

variable "APP_NAME" {
  default = "fargate-app"
}

variable "ALB_LISTEN" {
  default = "80"
}

variable "ALB_PROTO" {
  default = "HTTP"
}

variable "TG_LISTEN" {
  default = "8080"
}

variable "TG_PROTO" {
  default = "HTTP"
}

variable "TG_HEALTHCHECK" {
  default = "/"
}

variable "TASK_CPU" {
  default = "256"
}

variable "TASK_MEM" {
  default = "512"
}

variable "TASK_COUNT" {
  default = "1"
}

