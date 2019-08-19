variable "ENV" {}

variable "aws_region" {
  description = "AWS region to launch server(s)."
  # Availability zone.
  default     = "eu-west-1"
}