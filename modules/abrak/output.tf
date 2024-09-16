output "initial_public_network_id" {
  value = {"public_network": local.public_networks[random_integer.random_index.result].network_id, "vm_id": arvan_abrak.vm_without_floatingip[*].id}
}