terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Docker Network
resource "docker_network" "monitoring" {
  name = "monitoring-net"
}

# Prometheus
resource "docker_volume" "prometheus_data" {
  name = "prometheus_data"
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = "prom/prometheus:latest"

  ports {
    internal = 9090
    external = 9090
  }

  volumes {
    # host_path      = "${path.module}/prometheus.yml"
    host_path      = "/home/alex/tp-opentofu-advanced/ateliers/opentofu-observability/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
  }

  volumes {
    volume_name    = docker_volume.prometheus_data.name
    container_path = "/prometheus"
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}

# NodeJs via Podinfo
resource "docker_container" "podinfo" {
  name  = "podinfo"
  image = "stefanprodan/podinfo:latest"

  ports {
    internal = 8080
    external = 8080
  }

  ports {
    internal = 9898
    external = 9898
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}


#  Grafana
resource "docker_volume" "grafana_data" {
  name = "grafana_data"
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = "grafana/grafana:latest"

  ports {
    internal = 3000
    external = 3000
  }

  volumes {
    volume_name    = docker_volume.grafana_data.name
    container_path = "/var/lib/grafana"
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}

# Loki 
resource "docker_volume" "loki_data" {
  name = "loki_data"
}

resource "docker_container" "loki" {
  name  = "loki"
  image = "grafana/loki:latest"

  ports {
    internal = 3100
    external = 3100
  }

  volumes {
    #host_path      = "${path.module}/loki-config.yaml"
    host_path      = "/home/alex/tp-opentofu-advanced/ateliers/opentofu-observability/loki-config.yaml"
    container_path = "/etc/loki/local-config.yaml"
  }

  volumes {
    volume_name    = docker_volume.loki_data.name
    container_path = "/data"
    read_only      = false
  }

  command = ["-config.file=/etc/loki/local-config.yaml"]

  networks_advanced {
    name = docker_network.monitoring.name
  }
}

