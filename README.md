# WordPress on AWS Tutorial

## 3-Tier Multi-AZ WordPress Application in Infrastrucure as Code (IAC)

### This repository branch holds the code base for my tutorial on Medium covering the installation and hosting of a secure and scalable WordPress application on AWS, created using Terraform.

1. ./network layer: Virtual Private Cloud (VPC) Infrastructure

- A single VPC and Internet Gateway (IGW)
- Two availability zones (AZs)
- A private application subnet, a private database subnet and a public subnet in each AZ
- Three route tables - one public which accepts traffic from and Internet Gateway, two private which accept incoming traffic from two Nat Gateways (hosted in the public subnet of each AZ)
