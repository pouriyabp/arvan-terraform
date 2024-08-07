locals {
  subnet_mask_length = tonumber(split("/", var.cidr)[1])

  subnet_size = pow(2, (32 - local.subnet_mask_length))

  last_ip_address = cidrhost(var.cidr, local.subnet_size - 2)
  dhcp_start = cidrhost(var.cidr, 20)
  dhcp_end = cidrhost(var.cidr, local.subnet_size - 21)

}
resource "arvan_network" "terraform_private_network" {
  region      = var.region
  description = var.description
  name        = var.name
  dhcp_range = {
    start = local.dhcp_start
    end   = local.dhcp_end
  }
  dns_servers    = var.dns_servers
  enable_dhcp    = true
  enable_gateway = true
  cidr           = var.cidr
  gateway_ip     = local.last_ip_address
}



