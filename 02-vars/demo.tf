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
    value   = "My first msg is ${var.sample}"
}

variable "number" {
    default = 100
}

output "op_number" {
  value     = var.number
}

# Declaring a list variale
variable "sample_list" {
    default = [
        "Devops",
        55,
        "chinna"
    ]
}

output "print_list" {
  value      = " Welcome To ${var.sample_list[0]} Trainig and the batch number is ${var.sample_list[1]} and the name is ${var.sample_list[3]}"
}
