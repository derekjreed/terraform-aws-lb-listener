# Configure the AWS Provider
/*provider "aws" {
  version    = "~> 2.0"
  region     = "eu-west-1"
  access_key = "<>"
  secret_key = "<>"
}*/

module lb_listener_fixed_response {
  source = "./lb_listener/"

  load_balancer_arn = "arn:aws:elasticloadbalancing:eu-west-1:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-2018-06"
  certificate_arn   = "arn:aws:iam::123456789012:server-certificate/new-server-cert"

  default_action = [
    {
      type = "fixed-response"

      fixed_response = [
        {
          content_type = "text/plain"
          message_body = "Resource not found."
          status_code = "404"
        }
      ]
      redirect = []
    }
  ]
}

module lb_listener_https_redirect {
  source = "./lb_listener/"

  load_balancer_arn = "arn:aws:elasticloadbalancing:eu-west-1:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188"
  port              = "80"
  protocol          = "HTTP"

  default_action = [
    {
      type = "redirect"

      fixed_response = []
      redirect = [
        {
          port = "443"
          protocol = "HTTPS"
          status_code = "HTTP_301"
        }
      ]
    }
  ]
}