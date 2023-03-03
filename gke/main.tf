# Configurar o provider do Google Cloud
provider "google" {
  project = var.project_id
  region  = var.region
}

# Criar o cluster GKE
resource "google_container_cluster" "gke" {
  name     = var.gke_name
  location = var.region

  # Criar os pools de nós
  dynamic "node_pool" {
    for_each = var.node_pools
    content {
      name = node_pool.key

      node_config {
        machine_type = node_pool.value.machine_type
        disk_size_gb = node_pool.value.disk_size_gb
        preemptible  = node_pool.value.preemptible
      }

      initial_node_count = node_pool.value.initial_node_count
    }
  }
}

# Exportar o nome do cluster GKE para outros módulos
output "name" {
  value = google_container_cluster.gke.name
}
