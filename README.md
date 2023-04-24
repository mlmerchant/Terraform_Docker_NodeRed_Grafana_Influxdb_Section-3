# Terraform_Docker_NodeRed_Grafana_Influxdb_Section-3

terraform.tfvars should contain the following:

ext_port = {
  nodered = {
    dev  = [1980]
    prod = [1880]
  }
  influxdb = {
    dev  = [8186]
    prod = [8086]
  }
  grafana = {
    dev  = [3100]
    prod = [3000]
  }
}
