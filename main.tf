# Configure kubernetes provider plugin
# leave the block empty to load the default 
# location (~/.kube/config).
provider "kubernetes" {}

# Use kubernetes Deployment to achieve scalability and availability.
# It will ensure that a specified number of pods are running at any
# one time. 
resource "kubernetes_deployment" "httpd" {
  metadata {
    name = "test-scalable-httpd"
    labels = {
      app = "ScalableHttpdTest"
    }
  }
  spec {
    replicas = var.num_replicas
    selector {
      match_labels = {
        app = "ScalableHttpdTest"
      }
    }
    template {
      metadata {
        labels = {
          app = "ScalableHttpdTest"
        }
      }
      spec {
        container {
          image = "httpd:${var.httpd_version}"
          name = "httpd"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Provision a load-balancer in order to expose
# the application into users.
resource "kubernetes_service" "httpd-svc" {
  metadata {
    name = "httpd-svc-test"
  } 
  spec {
    selector = {
      app = kubernetes_deployment.httpd.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port = var.exposed_port
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

# Give an output of which IP address that will be exposed to user.
output "lb_ip" {
  value = kubernetes_service.httpd-svc.load_balancer_ingress.0.ip
}
