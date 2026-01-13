terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "~> 3.0"
        }
    }
}

provider "docker" {}

resource "docker_image" "nginx" {
    name = "nginx:latest"
    keep_locally = false
}

resource "docker_container" "nginx_container" {
    image = docker_image.nginx.name
    name = "demo-nginx"
    ports {
        internal = 80
        external = 8080
    }
}

output "nginx_url" {
    value = "http://localhost:8080"
}