output "api_url" {
  value = "http://localhost:${var.api_port}"
}

output "postgres_container" {
  value = docker_container.postgres_container.name
}

output "redis_container" {
  value = docker_container.redis_container.name
}
