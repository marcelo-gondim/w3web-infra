# Configurar o provider do Google Cloud
provider "google" {
  project = var.project_id
  region  = var.region
}

# Criar o cluster GKE
module "gke" {
  source   = "./gke"
  name     = var.gke_name
  location = var.region
  network  = var.gke_network
  node_pools = {
    for name, pool in var.node_pools : name => {
      machine_type = pool.machine_type
      disk_size_gb = pool.disk_size_gb
      preemptible  = pool.preemptible
      initial_node_count = pool.initial_node_count
    }
  }
}

# Instalar o Nginx Ingress
module "nginx_ingress" {
  source             = "./nginx-ingress"
  cluster_name       = module.gke.name
  external_ip_name   = var.external_ip_name
  external_ip_region = var.region
}

# Instalar o cert-manager
module "cert_manager" {
  source        = "./cert-manager"
  gcp_project   = var.project_id
  email_address = var.letsencrypt_email
}

# Criar os recursos do Ingress para cada domínio
module "ingress_resources" {
  source      = "./ingress-resources"
  domains     = var.domains
  gke_cluster = module.gke.name
}