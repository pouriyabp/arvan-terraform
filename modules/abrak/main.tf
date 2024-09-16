
data "arvan_images" "terraform_image" {
  region     = var.region
  image_type = "distributions" // or one of: arvan, private
}


locals {
  chosen_image = try(
    [for image in data.arvan_images.terraform_image.distributions : image
    if image.distro_name == var.vm-distro && image.name == var.vm-distro-version],
    []
  )
}



data "arvan_security_groups" "security_groups" {
  region = var.region
}




data "arvan_networks" "network_lists" {
  region = var.region
}


data "arvan_volumes_v2" "volume_list" {
  region = var.region
}

locals {
  public_networks = [
    for network in data.arvan_networks.network_lists.networks :
    network if length(regexall("شبکه پیش فرض", network.name)) > 0
  ]
}



resource "random_integer" "random_index" {
  min = 0
  max = length(local.public_networks) - 1
}

locals {
  
  selected_public_network = var.public_ip == true ? element(local.public_networks, random_integer.random_index.result) : null

  network_list = tolist(data.arvan_networks.network_lists.networks)
  chosen_network = try(
    [for network in local.network_list : network.network_id
    if network.name == var.vm-network],
    []
  )
  final_network_list = var.public_ip == true ? concat(local.chosen_network, [local.selected_public_network.network_id]) : local.chosen_network

  network_object = [for id in local.final_network_list : { network_id = id }]

  network_configs = [
    for network_id in local.final_network_list : {
      network_id = network_id
    }
  ]
}






locals {
  
  security_list = tolist(data.arvan_security_groups.security_groups.groups)
  chosen_security_group = try(
    [for group in local.security_list : group
    if group.name == var.vm-security_group],
    []   
  )

}


locals {
  volumes_list = tolist(data.arvan_volumes_v2.volume_list.volumes)
  chosen_volume = try(
  [
    for volume in local.volumes_list : volume.id
    if volume.name == var.volumes ],
    []
  )
  

}


resource "arvan_floating_ip" "terraform_floating_ip" {
  count       = var.floating-ip == true ? var.vm-count : 0
  region      = var.region
  description = "floating ip"
}



# resource "arvan_abrak" "vm_with_floatingip" {
#   depends_on = [local.chosen_security_group, local.chosen_network, arvan_floating_ip.terraform_floating_ip]
#   timeouts {
#     create = "1h30m"
#     update = "2h"
#     delete = "20m"
#     read   = "10m"
#   }
#   region          = var.region
#   name            = "${var.vm-name}-${count.index + 1}"
#   count           = var.floating-ip == true && var.public_ip == false ? var.vm-count : 0
#   image_id        = local.chosen_image[0].id
#   flavor_id       = var.vm-plan
#   disk_size       = var.vm-disk-size
#   ssh_key_name    = var.vm-ssh-key-name

#   networks = [
#     {
#       network_id = local.chosen_network[0]
#     }
#   ]
#   security_groups = [local.chosen_security_group[0].id]
#   floating_ip = {
#   floating_ip_id = arvan_floating_ip.terraform_floating_ip[count.index].id
#   network_id     = local.chosen_network[0]
#   }
# }


resource "arvan_abrak" "vm_without_floatingip" {
  depends_on = [local.chosen_security_group, local.chosen_network]
  timeouts {
    create = "1h30m"
    update = "2h"
    delete = "20m"
    read   = "10m"
  }
  region          = var.region
  name            = "${var.vm-name}-${count.index + 1}"
  count           = var.floating-ip == false ? var.vm-count : 0
  image_id        = local.chosen_image[0].id
  flavor_id       = var.vm-plan
  disk_size       = var.vm-disk-size
  ssh_key_name    = var.vm-ssh-key-name
  networks = local.network_configs
  security_groups = [local.chosen_security_group[0].id]
  volumes = local.chosen_volume
}




