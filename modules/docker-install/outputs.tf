output "docker_install_snippet" {
  value = cloudinit_config.docker_install_config.rendered
}