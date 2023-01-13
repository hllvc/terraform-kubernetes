variable "cluster_endpoint" {
  description = "Kubernetes cluster endpoint."
  type        = string
  default     = "https://cluster_endpoint:port"
}

variable "client_certificate" {
  description = "Kubernetes client certificate. Base64 encoded."
  type        = string
  default     = ""
}

variable "client_key" {
  description = "Kubernetes client key. Base64 encoded."
  type        = string
  default     = ""
}

variable "cluster_ca_certificate" {
  description = "Kubernetes cluster CA certificate. Base64 encoded."
  type        = string
  default     = ""
}
