variable "region" {
  type = string
  default = "ir-thr-c2"
}

variable "description" {
  type = string
  default = "default description"
}

variable "name" {
  type = string
  default = "private_network"
}

variable "cidr" {
  type = string
  default = "10.120.255.0/24"
}

variable "dns_servers" {
  type = list(string)
  default = [ "185.206.92.250", "1.1.1.1" ]
}
