# Terraform AWS VPC and EC2 Instances Setup

This repository contains a Terraform configuration to create a Virtual Private Cloud (VPC) with public and private subnets, EC2 instances, and a security group in AWS.

## Resources Created

- **VPC**: A VPC with CIDR block `10.0.0.0/16`.
- **Subnets**:
  - **Public Subnet**: `10.0.1.0/24` (with public IP assignment).
  - **Private Subnet**: `10.0.2.0/24`.
- **Internet Gateway**: Allows internet access to the VPC.
- **Route Tables**: Configures routes for the public subnet.
- **Security Group**: Allows SSH (port 22) to EC2 instances.
- **EC2 Instances**:
  - **Public EC2 Instance**: In the public subnet with public IP.
  - **Private EC2 Instances**: Two instances in the private subnet without public IP.

## Files

- **main.tf**: Contains the core resources (VPC, Subnets, Instances).
- **output.tf**: Outputs the IDs and public IPs of the created EC2 instances.
- **variables.tf**: Defines input variables such as subnet AZs, instance types, and AMI IDs.

## Variables

- `public_subnet_az`: Availability zone for the public subnet (default: `ap-south-1a`).
- `private_subnet_az`: Availability zone for the private subnet (default: `ap-south-1b`).
- `instance_type`: EC2 instance type (default: `t2.micro`).
- `public_ami`: AMI ID for the public EC2 instance.
- `private_ami`: AMI ID for the private EC2 instances.

## Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/terraform-aws-vpc-ec2.git
   cd terraform-aws-vpc-ec2
   ```
2. Initialize Terraform:
    ```bash
    terraform init
    ```
3. Apply the configuration:
    ```bash
    terraform apply
    ```
4. View the output:
   ```bash
   terraform output
   ```
5. destroy the resources:
 ```bash
 terraform destroy
 ```

## Conclusion
This setup provides a basic VPC with public and private subnets, EC2 instances, and a security group in AWS. It serves as a foundation for more advanced cloud architectures.