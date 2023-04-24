variable "image" {
  type        = map(any)
  description = "Image for the container"
  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "influxdb:2.7.0"
      prod = "influxdb:2.7.0"
    }
    grafana = {
      dev  = "grafana/grafana-oss:latest"
      prod = "grafana/grafana-oss:latest"
    }
  }
}

# defined in terraform.tfvars
variable "ext_port" {
  type = map(any)
  # sensitive = true
  validation {
    condition = (
      max(var.ext_port["nodered"]["dev"]...) <= 65535 &&
      min(var.ext_port["nodered"]["dev"]...) >= 1980 &&
      max(var.ext_port["nodered"]["prod"]...) <= 1900 &&
      min(var.ext_port["nodered"]["prod"]...) >= 1880
    )

    error_message = "External port must be in valid port range of 1880-1889 for Prod and 1990 - 65535 for Dev."
  }
}

