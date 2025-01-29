variable "namespace" {
  description = "The namespace where the resources will be created"
}

variable "networks" {
  type    = list(string)
  default = ["cardano-mainnet", "cardano-preprod", "cardano-preview", "cardano-vector-testnet"]
}

resource "kubernetes_service_v1" "well_known_service_grpc" {
  for_each = { for network in var.networks : "${network}" => network }

  metadata {
    name      = "utxorpc-${each.value}-grpc"
    namespace = var.namespace
  }

  spec {
    port {
      name     = "grpc"
      protocol = "TCP"
      port     = 50051
    }

    selector = {
      "cardano.demeter.run/network" = each.value
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service_v1" "well_known_service_grpc_web" {
  for_each = { for network in var.networks : "${network}" => network }
  metadata {
    name      = "utxorpc-${each.value}-grpc-web"
    namespace = var.namespace
  }

  spec {
    port {
      name     = "grpc-web"
      protocol = "TCP"
      port     = 50051
    }

    selector = {
      "cardano.demeter.run/network" = each.value
    }

    type = "ClusterIP"
  }
}
