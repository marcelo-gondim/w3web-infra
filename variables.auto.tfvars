project_id = "consummate-yew-316118"
region     = "southamerica-east1-c"
gke_name = "w3web-cluster"
gke_network = "default"

node_pools = {
  "pool-reserved" = {
    machine_type       = "n2d-standard-2"
    disk_size_gb       = 20
    preemptible        = false
    initial_node_count = 1
  },
  "pool-spot" = {
    machine_type       = "n2d-standard-2"
    disk_size_gb       = 20
    preemptible        = true
    initial_node_count = 3
  }
}
letsencrypt_email = "hideman@gmail.com"
domains = ["meuvicio.com","w3web.com.br", "viciadasemesmaltes.com"]
external_ip_name = "w3web"
