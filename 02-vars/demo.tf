# Declaring a variable
variable "sample" {
  default   = "Hello word"
}

# Printing on output
output "op" {
    value   = var.sample
}

# Whenever you want to print a variable in the group of words, you need to use the bash syntax
output "ops" {
    value = "My first msg is ${var.sample}"
}
