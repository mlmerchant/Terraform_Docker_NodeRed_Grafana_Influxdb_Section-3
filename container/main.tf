resource "random_string" "random" {
  count   = var.count_in
  length  = 4
  special = false
  upper   = false

  lifecycle {
    ignore_changes = [result]
  }

}


resource "docker_container" "app_container" {
  count = var.count_in
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in

  ports {
    internal = var.internal_in
    external = var.external_in[count.index]
  }
  lifecycle {
    ignore_changes = [ports[0].external, image]
  }
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      volume_name    = module.volume[count.index].volume_output[volumes.key]
    }
  }
}

module "volume" {
  source       = "./volume"
  count        = var.count_in
  volume_count = length(var.volumes_in)
  volume_name  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
}
