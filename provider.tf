# Configure the Kubernetes Provider
provider "kubernetes" {
  host = var.cluster_endpoint

  # client_certificate     = var.client_certificate
  # client_key             = var.client_key
  # cluster_ca_certificate = var.cluster_ca_certificate
  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}
