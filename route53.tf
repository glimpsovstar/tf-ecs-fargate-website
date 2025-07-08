# Data source to get YOUR hosted zone
data "aws_route53_zone" "david_joo" {
  name         = "david-joo.sbx.hashidemos.io"
  private_zone = false
}

# A record to point your subdomain to the ALB
resource "aws_route53_record" "website" {
  zone_id = data.aws_route53_zone.david_joo.zone_id
  name    = "website"  # This creates website.david-joo.sbx.hashidemos.io
  type    = "A"

  alias {
    name                   = aws_lb.website.dns_name
    zone_id                = aws_lb.website.zone_id
    evaluate_target_health = true
  }
}