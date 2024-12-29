locals {
  name = "${var.name}-${var.network}"
  role = "proxy"

  prometheus_port = 9187
  prometheus_addr = "0.0.0.0:${local.prometheus_port}"
  proxy_port      = 8080
  proxy_addr      = "0.0.0.0:${local.proxy_port}"
}


variable "certs_secret" {
  type    = string
  default = "proxy-certs"
}

variable "cloud_provider" {
  type    = string
  default = "aws"
}

variable "cluster_issuer" {
  type    = string
  default = "letsencrypt"
}

variable "dns_zone" {
  type    = string
  default = "demeter.run"
}

variable "environment" {
  type    = string
  default = null
}

variable "extension_name" {
  type = string
}

variable "healthcheck_port" {
  type    = number
  default = null
}

variable "image_tag" {
  type = string
}

variable "namespace" {
  type = string
}

variable "name" {
  type    = string
  default = "proxy"
}

variable "network" {
  type = string
}

variable "replicas" {
  type    = number
  default = 1
}

variable "versions" {
  type    = list(string)
  default = ["2"]
}

variable "resources" {
  type = object({
    limits = object({
      cpu    = string
      memory = string
    })
    requests = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    limits : {
      cpu : "50m",
      memory : "250Mi"
    }
    requests : {
      cpu : "50m",
      memory : "250Mi"
    }
  }
}

variable "tolerations" {
  type = list(object({
    effect   = string
    key      = string
    operator = string
    value    = optional(string)
  }))
  default = [
    {
      effect   = "NoSchedule"
      key      = "demeter.run/compute-profile"
      operator = "Exists"
    },
    {
      effect   = "NoSchedule"
      key      = "demeter.run/compute-arch"
      operator = "Equal"
      value    = "arm64"
    },
    {
      effect   = "NoSchedule"
      key      = "demeter.run/availability-sla"
      operator = "Exists"
    }
  ]
}
