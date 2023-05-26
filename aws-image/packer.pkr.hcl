packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
variable "accesskey" {
  type = string
  default = " "  # vault aws credentials
}

variable "secretkey" {
  type = string
  default = " "  # vault aws credentials
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
   provisioner "shell" {
    inline = ["sudo add-apt-repository ppa:openjdk-r/ppa", "sudo apt-get update", "sudo apt-get install -y openjdk-8-jdk", "java -version", "sudo apt-get install -y tomcat8"]
  }
  post-processor "awsami-tag" {
    repository = "samimbsnl"
    tags       = ["ubuntu-xenial"]
  }
}
