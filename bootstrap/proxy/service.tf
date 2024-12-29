resource "kubernetes_service_v1" "proxy_service_aws" {
  for_each = toset([for n in toset(["loadbalancer"]) : n if var.cloud_provider == "aws"])

  metadata {
    name      = local.name
    namespace = var.namespace
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type" : "instance"
      "service.beta.kubernetes.io/aws-load-balancer-scheme" : "internet-facing"
      "service.beta.kubernetes.io/aws-load-balancer-type" : "external"
      "service.beta.kubernetes.io/aws-load-balancer-healthcheck-protocol" : "HTTPS"
      "service.beta.kubernetes.io/aws-load-balancer-healthcheck-path" : "/dmtr_health"
    }
  }

  spec {
    load_balancer_class = "service.k8s.aws/nlb"
    selector = {
      role = "proxy-${each.value}"
    }

    port {
      name        = "proxy"
      port        = 8080
      target_port = 8080
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_service_v1" "proxies" {
  for_each = toset([for n in toset(["loadbalancer"]) : n if var.cloud_provider == "gcp"])

  metadata {
    name      = local.name
    namespace = var.namespace
    annotations = {
      "cloud.google.com/l4-rbs" = "enabled"
    }
  }

  spec {
    external_traffic_policy = "Local"
    selector = {
      role = "proxy-${each.value}"
    }

    port {
      name        = "proxy"
      port        = 443
      target_port = 8080
      protocol    = "TCP"
    }

    port {
      name        = "health"
      port        = 80
      target_port = 9187
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }
}
