
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
  environment_vars = [
    "FOO=hello world",
  ]
  inline = [
    "echo Adding file to Docker Container",
    "echo \"FOO is $FOO\" > example.txt",
  ]
}

}
