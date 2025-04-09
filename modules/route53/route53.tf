resource "aws_route53_record" "tfe_docker_mounted" {
  zone_id = var.route53_zone_id
  name    = "${var.aws_instance_name}.${var.route53_zone_name}"
  type    = "A"
  ttl     = 300
  records = [var.tfe_instance_public_ip]
}