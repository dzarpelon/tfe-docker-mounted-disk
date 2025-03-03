output "docker_install_snippet" {
  value = data.cloudinit_config.docker_install_config.rendered
}