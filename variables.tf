variable "project_id" {
  description = "The ID of the GCP project"
}

variable "region" {
  description = "The region where the GKE cluster will be located"
  default     = "southamerica-east1-c"
}

variable "gke_name" {
  description = "The name of the GKE cluster"
}

variable "gke_network" {
  description = "The name of the VPC network"
}

variable "letsencrypt_email" {
  description = "The email address of the Let's Encrypt account"
}

variable "domains" {
  description = "A list of domains to secure with Let's Encrypt certificates"
  type        = list(string)
}

variable "external_ip_name" {
  description = "The name of the external IP address to use for the Ingress"
}

variable "node_pools" {
  type = map(object({
    machine_type       = string
    disk_size_gb       = number
    preemptible        = bool
    initial_node_count = number
  }))
}