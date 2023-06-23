variable "location" {
  type = string
}

variable "prefix" {
  type = string
}

variable "tags" {
  description = "Default tags to apply to all resources."
  type        = map(any)
}

