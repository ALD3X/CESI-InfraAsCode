terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "stack_network" {
  name = "opentofu_network"
}

resource "docker_volume" "postgres_data" {
  name = "postgres_data"
}

resource "docker_volume" "redis_data" {
  name = "redis_data"
}

resource "docker_image" "postgres" {
  name         = "postgres:16"
  keep_locally = false
}

resource "docker_container" "postgres_container" {
  image = docker_image.postgres.name
  name  = "postgres"
  env = [
    "POSTGRES_DB=${var.postgres_db}",
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}"
  ]
  networks_advanced {
    name = docker_network.stack_network.name
  }
  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }
  ports {
    internal = 5432
    external = 5432
  }
}

resource "docker_image" "redis" {
  name         = "redis:7"
  keep_locally = false
}

resource "docker_container" "redis_container" {
  image = docker_image.redis.name
  name  = "redis"
  networks_advanced {
    name = docker_network.stack_network.name
  }
  volumes {
    volume_name    = docker_volume.redis_data.name
    container_path = "/data"
  }
  ports {
    internal = 6379
    external = 6379
  }
}

resource "docker_image" "api_image" {
  name         = "opentofu_api:latest"
  build {
    context    = "${path.module}/api"
  }
}

resource "docker_container" "api_container" {
  image = docker_image.api_image.name
  name  = "opentofu_api"
  depends_on = [
    docker_container.postgres_container,
    docker_container.redis_container
  ]
  networks_advanced {
    name = docker_network.stack_network.name
  }
  ports {
    internal = 3000
    external = var.api_port
  }

  env = [
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=${var.postgres_db}"
  ]
}

