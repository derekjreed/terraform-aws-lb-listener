resource "aws_lb_listener" "this" {

  load_balancer_arn = var.load_balancer_arn
  port = var.port
  protocol = var.protocol
  ssl_policy = var.ssl_policy
  certificate_arn = var.certificate_arn

  dynamic "default_action" {
    for_each = var.default_action
    content {
      type = default_action.value.type

      dynamic "fixed_response" {
        for_each = default_action.value.fixed_response
        content {
          content_type = fixed_response.value.content_type
          message_body = fixed_response.value.message_body
          status_code = fixed_response.value.status_code
        }
      }
      dynamic "redirect" {
        for_each = default_action.value.redirect
        content {
          port = redirect.value.port
          protocol = redirect.value.protocol
          status_code = redirect.value.status_code
        }
      }
    }
  }
}