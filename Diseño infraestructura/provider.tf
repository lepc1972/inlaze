provider "aws" {

  region                   = "us-east-2"
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files      = ["~/.aws/config"]
  #profile                  = "personal"


}

/*provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws-iam-authenticator"
    args        = ["token", "-i", module.eks.cluster_name]
  }
}*/

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  # Configuración de autenticación sin usar 'exec'
  token = data.aws_eks_cluster_auth.cluster.token
}

resource "kubernetes_deployment" "nginx_deployment" {
  metadata {
    name = "nginx-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx_service" {
  metadata {
    name = "nginx-service"
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}