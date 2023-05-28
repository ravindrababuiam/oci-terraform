variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
variable "availability_domain" {}
variable "my_public_ip_cidr" {
  default = "0.0.0.0/0"
}
variable "environment" {
  default = "staging"
}
variable "install_longhorn" {
  default = true
}
variable "install_nginx_ingress" {
  default = true
}
variable "install_certmanager" {
  default = true
}
variable "certmanager_email_address" {
  default = "ravindrababu.iam@gmail.com"
}
variable "expose_kubeapi" {
  default = true
}

# Images in eu-zurich-1 zone
# change the image ocid based on your zone
# See README.md -> How to list all the OS images
variable "os_image_id" {
  default = "ocid1.image.oc1.iad.aaaaaaaalharp53tw6htht7hirwa5vohbu6td5ddhevsaidpeisspwmcm6fq" # Canonical-Ubuntu-22.04-aarch64-2022.11.06-0
  # default = "ocid1.image.oc1.eu-zurich-1.aaaaaaaaz4kb57ds3nepbbz7phv4pjgqs3737g5xmusfu5un5srybcybptaa" # Oracle-Linux-8.6-aarch64-2022.12.15-0
}

module "k8s_cluster" {
  os_image_id               = var.os_image_id
  public_key_path           = var.public_key_path
  region                    = var.region
  availability_domain       = var.availability_domain
  compartment_ocid          = var.compartment_ocid
  my_public_ip_cidr         = var.my_public_ip_cidr
  environment               = var.environment
  install_longhorn          = var.install_longhorn
  install_nginx_ingress     = var.install_nginx_ingress
  install_certmanager       = var.install_certmanager
  certmanager_email_address = var.certmanager_email_address
  expose_kubeapi            = var.expose_kubeapi
  source                    = "../"
}

output "k8s_servers_ips" {
  value = module.k8s_cluster.k8s_servers_ips
}

output "k8s_workers_ips" {
  value = module.k8s_cluster.k8s_workers_ips
}

output "public_lb_ip" {
  value = module.k8s_cluster.public_lb_ip
}
