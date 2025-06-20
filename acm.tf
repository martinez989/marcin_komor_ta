resource "aws_route53_zone" "main" {
  name = var.root_domain_name

  tags = {
    Name = "${var.project_name}-${var.root_domain_name}-zone"
  }
}

resource "aws_acm_certificate" "main" {
  domain_name       = "${var.subdomain_name}.${var.root_domain_name}"
  validation_method = "DNS"
  tags = {
    Name = "${var.project_name}-acm-cert"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      value   = dvo.resource_record_value
      zone_id = aws_route53_zone.main.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  ttl             = 60
  zone_id         = each.value.zone_id
  records         = [each.value.value]
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}


resource "aws_route53_record" "alb_a_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "${var.subdomain_name}.${var.root_domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }
}