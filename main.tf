resource "kubernetes_ingress_v1" "demo_ingress" {
  metadata {
    name = "demo-ingress"
  }

  spec {
    default_backend {
      service {
        name = "myapp-1"
        port {
          number = 8080
        }
      }
    }

    rule {
      http {
        path {
          backend {
            service {
              name = "myapp-1"
              port {
                number = 8080
              }
            }
          }

          path = "/app1/*"
        }
      }
    }

    tls {
      secret_name = "tls-secret"
    }
  }
}

resource "kubernetes_service_v1" "demo" {
  metadata {
    name = "myapp-1"
  }
  spec {
    selector = {
      app = kubernetes_pod.demo.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 8080
      target_port = 80
    }

    type = "NodePort"
  }
}

resource "kubernetes_pod" "demo" {
  metadata {
    name = "terraform-demo"
    labels = {
      app = "myapp-1"
    }
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "demo"

      port {
        container_port = 8080
      }
    }
  }
}
