terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}


resource "docker_network" "devops_net" {
  name = "devops_net"
}

resource "docker_volume" "pg_data" {
  name = "pg_data"
}

resource "docker_volume" "gitea_data" {
  name = "gitea_data"
}

resource "docker_volume" "jenkins_home" {
  name = "jenkins_home"
}

resource "docker_volume" "sonar_data" {
  name = "sonar_data"
}


resource "docker_image" "postgres" {
  name = "postgres:15"
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_DB=sonarqube",
    "POSTGRES_USER=sonar",
    "POSTGRES_PASSWORD=sonar"
  ]

  ports {
    internal = 5432
    external = 5432
  }

  volumes {
    volume_name    = docker_volume.pg_data.name
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name = docker_network.devops_net.name
  }
}


resource "docker_image" "gitea" {
  name = "gitea/gitea:latest"
}

resource "docker_container" "gitea" {
  name  = "gitea"
  image = docker_image.gitea.image_id

  env = [
    "USER_UID=1000",
    "USER_GID=1000"
  ]

  ports {
    internal = 3000
    external = 3000
  }

  volumes {
    volume_name    = docker_volume.gitea_data.name
    container_path = "/data"
  }

  networks_advanced {
    name = docker_network.devops_net.name
  }

  depends_on = [docker_network.devops_net]
}


resource "docker_image" "jenkins" {
  name = "jenkins/jenkins:lts-jdk21"
}

resource "docker_container" "jenkins" {
  name  = "jenkins"
  image = docker_image.jenkins.image_id

  ports {
    internal = 8080
    external = 8080
  }

  ports {
    internal = 50000
    external = 50000
  }

  volumes {
    volume_name    = docker_volume.jenkins_home.name
    container_path = "/var/jenkins_home"
  }

  networks_advanced {
    name = docker_network.devops_net.name
  }

  depends_on = [docker_network.devops_net]
}


resource "docker_image" "sonarqube" {
  name = "sonarqube:community"
}

resource "docker_container" "sonarqube" {
  name  = "sonarqube"
  image = docker_image.sonarqube.image_id

  env = [
    "SONAR_JDBC_URL=jdbc:postgresql://postgres:5432/sonarqube",
    "SONAR_JDBC_USERNAME=sonar",
    "SONAR_JDBC_PASSWORD=sonar"
  ]

  ports {
    internal = 9000
    external = 9000
  }

  volumes {
    volume_name    = docker_volume.sonar_data.name
    container_path = "/opt/sonarqube/data"
  }

  networks_advanced {
    name = docker_network.devops_net.name
  }

  depends_on = [
    docker_container.postgres
  ]
}
