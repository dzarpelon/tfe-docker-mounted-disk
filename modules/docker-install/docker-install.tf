data "cloudinit_config" "docker_install_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/docker-install.tpl")
  }
}