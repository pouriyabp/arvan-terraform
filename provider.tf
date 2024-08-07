terraform {
  required_providers {
    arvan = {
      source = "terraform.arvancloud.ir/arvancloud/iaas"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "arvan" {
  api_key = var.ApiKey

}

