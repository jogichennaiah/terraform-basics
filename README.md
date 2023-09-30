# terraform-basics

# terrafrm-basics

This repository contains all the basics that are needed to learn and start with Terraform.

>>> What is terraform

```
Terraform is an open-source infrastructure as code (IaC) tool developed by HashiCorp. 

It allows you to define and provision infrastructure resources in a declarative and version-controlled manner. 
With Terraform, you can define the desired state of your infrastructure using a domain-specific language called HashiCorp Configuration Language (HCL) 
```

>>> Terraform only recognizes the files that end with *.tf or *.tfvars 

*   All the infra files end's with *.tf 
*   All the variable files ends with `*.tfvars` and `terraform.tfvars` is the default terraform variables file which will be recognized by terraform by default. 
*   Any variables file *.tfvars part from terraform.tfvars has to be explicity mentioned while running terraform commands.

> How to supply the varaibles file as a part of the terraform apple ?

```
    $ terraform plan -var-file=dev.tfvars 
```

> How to supply variables from the command line ? use -var city=delhi

```
    $  terraform plan -var-file=dev.tfvars  -var states=28
```


### Attribute vs Argument in Terraform 

Argument   : This comes up as a part of the resource creation! This is to define properties to the resource you're creating.
```
argument example : 
                    ami , security_group , key_name
```
attribute  : These are the properties of the resource which will only be available after the resource creation only 

```
Attribute example : 
                    private_ip, vm_id, network_attributes
```

>>> You cannot create either an attibute nor an argument. You just need to stick to the provider documentation.


### Can we write TF Code in multiples files of a folder ?

```
YES! As long as your code is in the files that ends with *.tf, terraform takes care of everything.

When you do a Terraform Plan, it will load all of them in Alphabetical Order. But compiles as per the logic. ( tf will take care of it. )

```


# Common Terraform Commands 

```
    $ terraform init 
    $ terraform plan
    $ terraform apply -auto-approve 

```

### If you want to supply any values of the variable from the command line. 
```

    $ terraform plan -var VARNAME=value
    $ terraform apply -auto-approve -var VARNAME=value

```

### If you want to supply any values of the variable from the anyother file apart from terraform.tfvars, you need to explicity pass the varaible file name to be used . 
```

    $ terraform plan -var-file=dev.tfvars
    $ terraform apply -auto-approve -var-file=dev.tfvars

``` 


### precedence 

```
    When compared to the values of the variables declared in terraform.tfvars, command line variables will have higher precendence

    -var / -var-file   >  terraform.auto.tfvars  > terraformtfvars > shell variables
```


### Shell Based Variables :

```
    These are the variables with least priority and this can be supplied by shell using export.

        $ export TF_VAR_varName=value 
    
    This is how we can supply the shell based variables
```


### What exactly happens when you run `terraform plan`  ? 

```
    When you run a terraform plan,  terraform is going to check the CURRENT STATE OF THE INFRASTRUCTURE and then it validates with what's there in the code that you're suppling against the terraform state file.

    If there are any changes ( how it comes to know ? Becuase of the above validation) , then terraform shows that to you during plan output.

    If you wan to want those changes, then you need to a `terraform apply` , when you do a terraform apply, your state will also be updated

    Eventually, your manual changes will be wiped off.
```

### Terraform has created some infrasturcure and then you manually went and updated the changes of the INFRA using console. Now if you Terraform Apply with the same old code , what will happen ???

```
    For Terraform, whatever is there in the CODE and as per that PLAN will be generated and for terraform PLAN is the source of truth, which means when you do a `terraform apply` , all your manual changes will be wiped off.

    99% of the times, a good setup will ensure you as a user won't be having write access on the console.
    Only the IAM Role, which we use to configure JENKINS will only have right access.
```


### Datasource In Terraform 

```
Datasource helps us to fetch the information of the already existing resources on your cloud.
```


### Modules In Terraform






### What all needs to be created ???
    1) Network      ( Done )
    2) Databases    ( MongoDB, MySQL, Redis, RabbitMQ )
    3) Backend / Applications Components


### For DB's , AWS offers PaS [ Managed Service for Databases ] and here is the advantage of it.
1) Backups and Restoration would be offered by the Cloud Provider 
2) Maintenance of the unerlying infrastructure will be handled by the Provider
3) Storage and Maintenance will be handled by the provider 
4) DB Maintenance will go planned and will be handled by the provider and sometimes it incurs downtime [ only for major upgrages ]
5) High Availability is offered as per the need.


MongoDB     ------->    Document DB    [ Our Applications Code : USER, CART, CATALOGUE are designed to operate with Mongo Without userName and password ]
MySQL       ------->    RDS 
Redis       ------->    Elastic Cache 
RabbitMQ    ------->    Amazon MQ      [Our Application is not compatible with. Hence, we go with RabbitMQ on EC2 only]


We will create 5 repos : 
1) Terraform-Databases [ this will be the root module ]
2) tf-module-docdb     [ this will be the backend module for Document DB ] 
3) tf-module-mysql     [ this will be the backend module for MySQL ] 
4) tf-module-redis     [ this will be the backend module for Redis ]
5) tf-module-rabbitmq  [ this will be the backend module for RabbitMQ ]  



### How can we read the information from another statefile ?

In our case, terraform-databases, should have the information of the VPC which is created by the terraform-vpc!!!
How can one repository reads the information from another state file.


```
Always ensure on adding the needed values as a OUTPUT. So that, those values will be recorded in statefule in a format that will be accessible by other modules.

All the databases, needs the subnet, vpc and other information from the network. Let's record the output.
So that DB module can be access it.
```


# Provisioners In Terraform

```
Provisioners helps us to do tasks on the TOP of the created Infra or on the top of the Infra where your terraform scripts are running.
```

# There are 4 types of provisioners available in Terraform

```
    1) File Provisioner         [ to copy the files to the provisioned infrastructure ]
    2) Connection Provisioner   [ to establish connection / authentication to the provisioned infrastructure]
    3) Remote Provisioner       [ to execute tasks on the top of the new provisioned infrastructure ]
    4) Local Provisioner        [ to execute tasks on the top of the server where you're running the terraform ]
```

>>> Points to be noted when dealing with provsioners
    1) Provsioners by default are create-time provisioner [ that means only during the creation of the resouce provisioners will be executed. Rest of the times, they won't be executed ]

    2) Provisioners are always supposed to be executed inside a resource [ If the provisioner fails, resource which was created would marked as tained or damaged, which would be recreated on the next TF Apply and that's why it's not recommended to run the provisioners with in the real resources ]

    PS : Real resources ??? Real resources are credible infra, we also have a dummy resource referred as null_resource.

    3) It's always recommended to run the provisioners under the null_resources only. This will restrict the recreation of infra, in the event of the provisioner failure.

    4) There are some event based provisioner triggers as well [ we will talk more about this later ] 