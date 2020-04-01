variable "load_balancer_arn" { //Required
  description = "(Required, Forces New Resource) The ARN of the load balancer."
  type        = string
}

variable "port" { //Required
  description = "(Required) The port on which the load balancer is listening."
  type        = string
}

variable "protocol" { //Optional
  description = "(Optional) The protocol for connections from clients to the load balancer. Valid values are TCP, TLS, UDP, TCP_UDP, HTTP and HTTPS. Defaults to HTTP."
  type        = string
}

variable "ssl_policy" { //Optional
  description = "(Optional) The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS."
  type        = string
  default     = null
}

variable "certificate_arn" { //Optional
  description = "(Optional) The ARN of the default SSL server certificate."
  type        = string
  default     = null
}

variable "http_to_https" { //Optional
  description = "(Optional) creates HTTP to HTTPS redirect."
  type        = bool
  default     = false
}

variable "resource_not_found" { //Optional
  description = "(Optional) creates fixed response for 404."
  type        = bool
  default     = true
}

variable "default_action" { //Either fixed_response or redirect needed
  type = list(object({
    type = string
    fixed_response = list(object({
      content_type = string
      message_body = string
      status_code = string
    }))
    redirect = list(object({
      port = string
      protocol = string
      status_code = string
    }))
  }))
}