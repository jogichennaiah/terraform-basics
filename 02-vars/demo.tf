# Declaring a variable
variable "sample" {
  default   = "Hello word"
}

# Printing on output
output "op" {
    value   = var.sample
}
