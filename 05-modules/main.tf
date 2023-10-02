#Calling ec2 module
module "ec2" {
    source     = "./ec2" 
}

#Calling security - group

module "ec2" {
    source     = "./security-group" 
}

