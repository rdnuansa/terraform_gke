variable "httpd_version" {
  default = "latest"
  description = "Httpd version"
}

variable "num_replicas" {
  default = 2
  description = "Number of pods replicas"
}

variable "exposed_port" {
  default = 80
  description = "Exposed port to user"
}
