#Calling ec2 module
module "ec2" {
    source     = "./ec2" 
    sg         = module.sg.sgid           # Step 2  : Passing the info the module that needs yhis variable over the root module
}

#Calling security - group

module "sg" {
    source     = "./sg" 
}

