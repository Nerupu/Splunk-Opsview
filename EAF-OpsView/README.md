# Documentation

## Overview

This repository contains tools and scripts to deploy and configure infrastructure for OspView tool.
To correctly run the whole process, you need to set up correct role in designated account and provide correct input JSON file. Please read carefully the following documentation.

Framework and tools used in this repository are:

1. Terraform
2. CloudFormation
3. Bash
4. Python
5. Ansible

The whole process is divided into several main steps:

1. Creation of the network stack done via terraform
2. Creation of the infrastructure stack done via terraform
3. Configuration of the infrastructure components via Ansible

## Input JSON

Navigate to folder `EAF-OpsView/scripts/json_configuration`, read the `README.md` file and follow the instructions.

Pre-requisites

The solution is designed keeping in mind the EAF AWS project, so almost all the pre-requisites mentioned below are a part of an account provisioning in EAF and shall be met by default.

 1.IAM role: The automation consumes an IAM role which leverages OpenID Connect authentication against the EAF AWS SSO to get time bound session/credentials. The role is created during the target account provisioning by EAF Platform support team. The role has all required policies associated with it for executing the automation and it comes with a session duration of 3 hours.

      Example of a role: capgemini-car-gha-oidc-f84344239770c07b

** The operator deploying the solution needs to check the IAM in the target account to identify the role, the ARN of the role is required as an input in the input JSON file

![alt text](image.png)

{
    "workflow_parameters": {
        "github_role_arn": "arn:aws:iam::123456789012:role/capgemini-car-gha-oidc-f84344239770c07b"
    },
}

 2.S3 Bucket: The solution utilizes an S3 bucket to store Terraform state. By default, the account provisioning process in EAF creates a bucket for the same. So, if the solution is being deployed in an EAF AWS account bearing account number 123456789012 in the us-east-1 AWS region, then the S3 bucket terraform-state-123456789012-eu-central-1 (terraform-state-ACCOUNTNUMBER-AWSREGION) must exist, and it will be used to store terraform state.

 3.DynamoDB Table: The solution utilizes AWS DynamoDB for terraform state locking to prevent concurrent runs on a project. By default, the account provisioning process in EAF creates a DynamoDB Table for the same. So, if the solution is being deployed in an EAF AWS account bearing account number 123456789012 in the eu-central-1 AWS region, then the DynamoDB table terraform-state-lock-123456789012-eu-central-1 (terraform-state-lock-ACCOUNTNUMBER-AWSREGION) must exist, and it will be used for terraform state locking.

 4.IPAM pool: The solution expects the target account to have IPAM pools available in the region the solution must be deployed. Again, as per the standard AWS account provisioning in EAF, the target accounts have shared IPAM pools which are region specific. The solution consumes the network address provided by the shared IPAM pool in the respective region of deployment in target account to build the network via terraform.
  ![alt text](image-1.png)

 5.IAM Policy: As per EAF standards the SSM session has to be encrypted via a KMS key. The KMS key and the IAM policy with the relevant authorization is pushed to the target account during the standard AWS account provisioning in EAF. As mentioned below in the Solution enablers section, the pipeline creates an SSM IAM role utilizing the aforementioned IAM policy. The name of the IAM policy is session-manager-encrypted-connect. Existence of the IAM policy in the target account has to be validated before the deployment.

Note: The operator deploying the solution has to ensure the above pre-requisites are met by checking the existence of the above resources in the target AWS account/region. This has to be done before the pipeline is executed and any deviation shall be reported to the EAF Platform support team.

Limitations:

 1. The solution as of now only supports the following AWS regions, which is inline with the regions supported by EAF

   •eu-central-1

Solution Enablers:
The current solution is an enhanced version of the initial solution developed by CIS. We have introduced automation to solution certain steps which were manual in the previous release. The following information is for the awareness of the teams deploying the solution.

 1. IAM Role for SSM: The solution creates an IAM role, the naming standard is as follows.
      RoleName: eaf-instance-ssm-region-role

eaf-instance-ssm-eu-role will be a role created when the deployment is done in AWS us-east-1 region.
  
  1. eaf-instance-ssm-eu-role  eu-central-1 region

The role comprises of all the required policies for it to be consumed for SSM console access and for ansible execution.

 2. S3 Bucket: The solution creates an S3 bucket in the same region as the deployment, this bucket is used for storing the Splunk install binaries, configuration and the bucket is also used in ansible configuration to facilitate SSM based access to ansible. The naming convention followed for the bucket is eaf-opsview-binaries-ACCOUNTNUMBER-AWSREGION,  an example would be eaf-splunk-binaries-858165505743-eu-central-1. The pipeline creates the bucket and uploads the Splunk configuration/binaries to the bucket as follows.

    i./splunk /binary/splunk-9.1.1-64e843ea36b1.x86_64.rpm (should be avaiable at vendor site)
   ii./splunk /deploymentServer/default_app/v1/inputs.conf (taken from provided documentation or at vendor site)

Note: The RPM is downloaded from the vendor site and exists in the repository.

3. Python code :

Script for AWS Resource Tag Checker:

   • Checks AWS resources (S3 bucket, DynamoDB table, managed IPAM pools) and exits with an error if any check fails.
   • Utilizes a class (AWSResourceTagChecker) to check tags on EC2 instances, VPCs, Subnets, and ALBs, providing a summary of results.

Script for S3 Bucket Creation and File Operations:

   • Manages local and S3 paths, creates bucket policies, and handles S3 operations including uploads and updates.
   • Ensures the existence of an S3 bucket, local directory, and performs file checks and uploads, updating a GitHub environment file.

Script for Creating tfvars JSON File:

   • Parses command-line arguments, loads configurations, and generates unique names for instances.
   • Configures volumes, load balancer parameters, and constructs a tfvars file for Terraform.
   • Outputs a tfvars file containing Terraform configuration details.

Script for Updating JSON:

   • Updates Terraform JSON data, collects subnet and security group information, and maps worker types to resources.
   • Saves the updated JSON data and repairs it if necessary, writing the result to an output file.

 Note: For more detailed information, please refer to the README.md file located in the scripts/create_architecture directory.

Scripts/create_architecture/README.md

   • Checks for S3 bucket availability, DynamoDB table existence, and managed IPAM pools.
   • Prints "All checks passed. Continuing with the program" if all checks pass.
   • Prints "One or more checks failed. Exiting the program." and exits with an error code if any check fails.
   • Defines commented-out code for assuming an AWS role using STS and validating AWS configuration.
   • Defines a class AWSResourceTagChecker with methods for checking tags on various AWS resources.
   • Private method _check_resource_tag checks if resources of a specified type have a specified tag.
   • Public methods (check_instance_tag, check_vpc_tag, check_subnet_tag, check_alb_tag) use_check_resource_tag.
   • Example usage checks for a specific tag on EC2 instance, VPC, Subnet, and ALB.
   • Prints results and exits with an error code if any check returns True.
   • Provides a summary indicating whether any resources have the specified tag.
   • Placeholder comment for additional script logic.

Script for S3 Bucket Creation and File Operations:

   • Defines local and S3 paths for RPM file, S3 bucket name, and S3 key.
   • Defines a bucket policy to deny non-SSL requests.
   • Initializes an S3 client, checks if the bucket exists, creates it, and sets the bucket policy if not.
   • Creates a local directory if it doesn't exist.
   • Checks if the RPM file exists in S3; if not, downloads and uploads it.
   • Updates a GitHub environment file with AWS region and S3 bucket name.
   • Prints a summary indicating the completion of various steps.

Script for Creating tfvars JSON File:

   • Defines code mappings for environment, instance, product, and worker type codes.
   • Uses argparse to parse a command-line argument for the configuration path.
   • Loads configuration data from the specified JSON file.
   • Sets up AWS credentials and region based on the loaded configuration.
   • Generates unique names for instances based on specified format and mappings.
   • Configures root and data volumes, load balancer parameters, and worker type counts.
   • Constructs a dictionary for generating Terraform variable (tfvars) files.
   • Writes the generated JSON data to a tfvars file.
   • Outputs a tfvars file containing configuration details for Terraform.

Script for Updating JSON:

   • Loads configuration data from the specified JSON file.
   • Defines a function repair_json to remove trailing commas in arrays and objects.
   • Reads updated Terraform JSON data from /tmp/terraform/terraform.json.
   • Calls functions (collecting_subnets and security_group) from the subnets module.
   • Creates dictionaries to map worker types to subnets and security groups.
   • Iterates through instances and updates subnets and security groups based on mappings.
   • Saves updated JSON data to /tmp/terraform/terraform.tfvars.json.
   • Reads content of updated tfvars file, replaces single quotes with double quotes.
   • Attempts to load the JSON data, and if decoding fails, tries to repair the JSON.
   • Writes the repaired or original JSON data to /tmp/terraform/output.json.

## Troubleshooting

If you encounter any issues while running the script, please ensure that:

- The input JSON file is properly formatted and contains all required fields.
- The script file paths are correct and all dependencies are installed.
- The script has execute permissions (`chmod +x <script_name>.sh`).

If issues persist, please refer to the script's error messages for further guidance.
