provider "aws" {}


terraform {
    backend "s3" {
        bucket  = "b55-terraform-bucket"
        key     = "dev/ec2/terraform.tfstate"
        region  = "us-east-1" 

    }
 }

variable "howManyYouWant" {
  default     = 2
 
}
