variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  default     = "aws-kubernetes-reliability"
}

variable "environment" {
  description = "The environment for the Kubernetes cluster"
  type        = string
  default     = "dev"
}