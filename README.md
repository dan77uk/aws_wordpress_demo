# WordPress on AWS Tutorial

## 3-Tier Multi-AZ WordPress Application in Infrastrucure as Code (IAC)

### This repository branch holds the code base for my tutorial on Medium covering the installation and hosting of a secure and scalable WordPress application on AWS, created using Terraform.

1. ./network layer: Virtual Private Cloud (VPC) Infrastructure

- A single VPC and Internet Gateway (IGW)
- Two availability zones (AZs)
- A private application subnet, a private database subnet and a public subnet in each AZ
- Three route tables - one public which accepts traffic from and Internet Gateway, two private which accept incoming traffic from two Nat Gateways (hosted in the public subnet of each AZ)

2. ./application layer:

- Security group rules for all resources
- AWS Relational Database Service (RDS) resource (rds.tf)
- AWS Secrets Manager (secrets.tf)
- Launch configuration (ec2.tf)
- Presentation - load balancer, listener, asuto scaling group (presentation.tf)

#### Installation Guide

This guide assumes you have Terraform installed and an AWS Profile configured with Access and Secret Access keys. Please note, this infrastructure will incur charges from AWS, for which you are responsible.

Before installing, create an s3 bucket with versioning enabled in order to store the Terraform state remotely, and ensure it's name matches the 'bucket' attribute in

- /network/backend.tf
- /application/backend.tf

and in the data resource in

- /application/data.tf

```
bucket = "your-bucket-name"
```

Then open a terminal in the root folder and run the following commands:

```bash
# create the VPC, subnets, route tables, nat gateways and internet gateway resources
cd ../network && terraform init
terraform apply

#create the EC2s, security groups, load balancer and auto-scaling group resources
cd ../application && terraform init
terraform apply
```
