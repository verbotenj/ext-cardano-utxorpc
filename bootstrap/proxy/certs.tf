resource "kubernetes_config_map" "proxy-certs" {
  metadata {
    namespace = var.namespace
    name      = local.certs_configmap
  }

  data = {
    "tls.crt" = file("${path.module}/tls.crt")
    "tls.key" = file("${path.module}/tls.key")
  }
}