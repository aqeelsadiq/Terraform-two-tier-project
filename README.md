# Terraform-two-tier-project
Deploy two tier application on aws using Terraform 

This repository contains a simple Terraform configuration to deploy a two-tier architecture on AWS. It provisions a VPC, an EC2 instance, an Elastic Load Balancer (ELB), and an Auto Scaling Group (ASG) with load balancing.

Files Included
vpc.tf: Defines the VPC and networking resources.
ec2.tf: Defines the EC2 instance configuration.
elb.tf: Defines the Elastic Load Balancer.
asg.tf: Configures the Auto Scaling Group (ASG) for high availability.
variables.tf: Contains input variable definitions.
outputs.tf: Defines the output values.
terraform.tfvars: Contains values for variables.
output.tf: to output the ids

# Prerequisites
Terraform
AWS CLI and configure it
AWS account with permissions to create VPC, EC2, ELB, and ASG resources.

# Setup Instructions
# Step 1: Clone the Repository

git clone https://github.com/aqeelsadiq/Terraform-two-tier-project.git
cd Terraform-two-tier-project
# Step 2: Configure AWS CLI
Ensure your AWS CLI is configured with proper credentials:


aws configure
# Step 3: Initialize Terraform
Run the following command to initialize the project:


terraform init
# Step 4: Plan the Terraform configuration
Run the following command to plan the project:
teraform plan

# Step 5: Apply the Terraform Configuration
Run the following command to create the infrastructure:

terraform apply
Type yes to confirm the changes.
you can also run below command
terraform apply --auto-approve

# Step 5: Access Outputs
Once the infrastructure is created, Terraform will output information like the public IP of the EC2 instance and the DNS name of the ELB. and also you will get other as mentioned in output.tf file

# Variables
Key variables used in the project can be found in variables.tf. You can modify them in the terraform.tfvars file to suit your requirements.

variable "aws-region" {}
variable "resource-name" {}
variable "vpc-cidr" {}
variable "pub-subnet" {
  type = list(map(string))
}
variable "pri-subnet" {
  type = list(map(string))
}
variable "ec2-ami" {}
variable "ec2-instance-type" {}

# Cleanup
To avoid incurring costs, destroy the infrastructure when you are done:

terraform destroy --auto-approve


This simple README includes all the essential steps and information specific about project. you can use this to design infra as well.
