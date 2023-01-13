resource "kubernetes_ingress" "demo_ingress" {
  metadata {
    name = "demo-ingress"
  }

  spec {
    backend {
      service_name = "myapp-1"
      service_port = 8080
    }

    rule {
      http {
        path {
          backend {
            service_name = "myapp-1"
            service_port = 8080
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
