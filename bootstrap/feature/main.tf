variable "namespace" {
  type = string
}

variable "operator_image_tag" {
  type = string
}

variable "api_key_salt" {
  type = string
}

variable "extension_url_suffix" {
  type    = string
  default = "utxorpc-m1.demeter.run"
}

variable "metrics_delay" {
  description = "the inverval for polling metrics data (in seconds)"
  default     = "60"
}

variable "metrics_step" {
  description = "the metrics prometheus step"
  default     = "10s"
}

variable "prometheus_url" {
  type    = string
  default = "http://prometheus-operated.demeter-system.svc.cluster.local:9090/api/v1"
}
