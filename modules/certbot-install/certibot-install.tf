resource "docker_image" "certbot" {
  name         = "certbot/certbot:latest"
  keep_locally = false
}

resource "docker_container" "certbot" {
  name  = "${var.instance_public_dns}-certbot"
  image = docker_image.certbot.name

  ports {
    internal = 80
    external = 80
  }

  volumes {
    host_path      = "/etc/letsencrypt"
    container_path = "/etc/letsencrypt"
  }

  command = [
    "certonly",
    "--standalone",
    "--non-interactive",
    "--agree-tos",
    "--email", var.certbot_email,
    "-d", var.instance_public_dns
  ]
}

