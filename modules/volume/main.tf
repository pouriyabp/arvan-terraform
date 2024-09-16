resource "arvan_volume_v2" "volume" {
  region = var.region
  name   = var.name
  size   = var.size
  type   = var.ssd ? "ssd-g1" : "hdd-g1" // hdd-g1 or ssd-g1
}
