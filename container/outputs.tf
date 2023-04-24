
output "application_access" {
  value = { for x in docker_container.app_container[*] : x.name => join(":", [x.network_data[0].ip_address], x.ports[*]["external"]) }
}

output "containers_text" {
  value = [for x in docker_container.app_container[*] : "${x.name}: ${x.network_data[0].ip_address}:${x.ports[0]["external"]}"]
}