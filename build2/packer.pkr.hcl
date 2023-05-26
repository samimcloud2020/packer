
packer {
    required_plugins {
      docker = {
        version = ">= 0.0.7"
        source = "github.com/hashicorp/docker"
      }
    }
  }



variable "image" {
  type    = string
  default = "ubuntu"
}


source "docker" "ubuntu" {
  commit = true
  image  = "${var.image}"
}


build {
  sources = ["source.docker.ubuntu"]

  provisioner "shell" {
    inline = ["echo Hello world!"]
  }
}
