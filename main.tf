module "create_private_network" {
  source = "./modules/network"
  count = length(var.network_list)
  region = var.region
  description = var.network_list[count.index].description
  name = var.network_list[count.index].name
  cidr = var.network_list[count.index].cidr
  dns_servers = var.network_list[count.index].dns_servers
}


# module "create_volume" {
#   source = "./modules/volume"
#   count = length(var.vm_list)
#   region = var.region
#   name = var.volumes_list[count.index].name
#   size = var.volumes_list[count.index].size
#   ssd = var.volumes_list[count.index].ssd
# }

module "create_vm" {
  depends_on = [ module.create_private_network]
  source = "./modules/abrak"
  count = length(var.vm_list)
  region = var.region
  vm-count = var.vm_list[count.index].count
  vm-name = var.vm_list[count.index].name
  vm-plan = var.vm_list[count.index].plan
  vm-distro = var.vm_list[count.index].distro
  vm-distro-version = var.vm_list[count.index].distro-version
  vm-disk-size = var.vm_list[count.index].disk-size
  vm-network = var.vm_list[count.index].network
  vm-security_group = var.vm_list[count.index].security_group
  floating-ip = var.vm_list[count.index].floating_ip
  public_ip = var.vm_list[count.index].public_ip
  vm-ssh-key-name = var.ssh_key_name 
  #volumes =  var.vm_list[count.index].volumes[0]
}





