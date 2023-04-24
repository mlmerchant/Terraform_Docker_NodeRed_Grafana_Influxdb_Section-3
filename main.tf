
module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image
}



module "container" {
  source      = "./container"
  for_each    = local.deployment
  count_in    = each.value.container_count
  name_in     = each.key
  image_in    = module.image[each.key].image_out
  internal_in = each.value.int
  external_in = each.value.ext
  volumes_in  = each.value.volumes
}

resource "local_file" "info" {
  content  = join("\n", [for x in module.container : join("\n", x["containers_text"])])
  filename = "${path.cwd}/containers.txt"
}
