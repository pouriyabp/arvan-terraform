variable "ApiKey" {
  type = string
  sensitive = true
}





variable "region" {
  type = string
  #default = "ir-thr-c2"
}

variable "ssh_key_name" {
  type = string
  description = "name of the ssh_key that you define in arvan panel"
  #default = "arvan"
}


variable "network_list" {
  type = list(object({
    name = string
    description = string
    cidr = string
    dns_servers = list(string)

  }))
  # default = [ {
  #   name = "test-network"
  #   description = "default"
  #   cidr = "10.110.255.0/24"
  #   dns_servers = [ "185.206.92.250", "1.1.1.1" ]
  # } ]
}


# you can't use floating ip with public ip together
variable "vm_list" {
  type = list(object({
    name = string
    plan = string
    distro = string
    distro-version = string
    count = number
    disk-size = number
    network = string
    security_group = string
    floating_ip = bool 
    public_ip = bool

  }))
  # default = [ {
  #   name = "test"
  #   plan = "eco-2-2-0"
  #   distro = "ubuntu"
  #   distro-version = "22.04"
  #   count = 3
  #   disk-size = 25
  #   network = "test-network"
  #   security_group = "default"
  #   floating_ip = false
  #   public_ip = false
    
  # } ]
  
}




