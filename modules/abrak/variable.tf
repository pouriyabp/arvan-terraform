variable "region" {
  type = string
  #default = "ir-thr-c2"
}

variable "vm-plan" {
  type    = string
  default = "eco-2-2-0"
  #default = "g1-12-4-0"
}

variable "vm-name" {
  type = string
  default = "test"
}

variable "vm-distro" {
  type = string
  default = "ubuntu"
}

variable "vm-distro-version" {
  type = string
  default = "22.04"
}


variable "vm-count" {
  type = number
  default = 1
}

variable "vm-disk-size" {
  type = number
  default = 25
}

variable "vm-ssh-key-name" {
  type = string
  default = "arvan"
}

variable "vm-network" {
  type = string
  default = "test-network"
}

variable "vm-security_group" {
  type = string
  default = "default"
}

variable "floating-ip" {
  type = bool
  default = false
}

variable "public_ip" {
  type = bool
  default = false
}


