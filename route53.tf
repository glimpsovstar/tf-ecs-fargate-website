# Data source to get the existing hosted zone
data "aws_route53_zone" "hashidemos" {
  name         = "sbx.hashidemos.io"
  private_zone = false
}

# A record to point your subdomain to the ALB
resource "aws_route53_record" "website" {
  zone_id = data.aws_route53_zone.hashidemos.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.website.dns_name
    zone_id                = aws_lb.website.zone_id
    evaluate_target_health = true
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-dns-record"
    Type = "route53-record"
  })
}