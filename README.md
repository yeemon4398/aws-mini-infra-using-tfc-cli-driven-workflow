# Create a mini infrastructure on the AWS cloud using Terraform Cloud's CLI-driven workflow #
## Architecture ##
![Cohort-tfc-cli-driven-wf](https://github.com/yeemon4398/aws-mini-infra-using-tfc-cli-driven-workflow/assets/40330106/39cc0b29-235b-4129-a96b-5976bfe53136)

## Terraform Cloud's CLI-Driven Workflow ##
![Cohort-tfc-cli-driven](https://github.com/yeemon4398/aws-mini-infra-using-tfc-cli-driven-workflow/assets/40330106/dd039a1e-30c6-45ae-8b85-aaa0d4c35022)

## Summary ##
- Included platforms and services
- Pre-requisites
- Connection between local PC and Terraform Cloud (TFC)
- Prepare Terraform configuration files
- Apply Terraform configuration to the AWS cloud using TFC
- Monitor triggers at TFC
- Verify resources at the AWS Cloud
- Clean up resources
<br>

## Details ##
### Included platforms and services ###
- AWS Account
- AWS Cloud Services
- Terraform CLI
- Terraform Cloud
<br>

### Pre-requisites ###
- AWS account [https://signin.aws.amazon.com/]
  - IAM user with related policy > Security credentials > Create access key
- Terraform CLI installation [https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli]
- Terraform Cloud account [https://app.terraform.io/public/signup/account]
<br>

### Connection between local PC and Terraform Cloud (TFC) ###
#### 1. Install Terraform CLI at Local PC ####
- Installation reference link - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

#### 2. Create a TFC account and create an API token ####
- TFC account creation link - https://app.terraform.io/public/signup/account
- Account settings > Tokens > Create an API token
- Take notes of created token because it will display at only creation time
  
#### 3. Create an organization and workspace with CLI-Driven Workflow ####
- Create an organization under the Terraform Cloud account
- Create a workspace with CLI-Driven Workflow under the previously created organization
- Set the preferred workspace name
- Read CLI-driven runs and follow up

#### 4. Login to the TFC from the local CLI ####
- Command - ```terraform login```
- Provide previously created token when prompt comes up
<br>

### Prepare Terraform configuration files ###
- Official documentation link of HCP provider for Terraform configuration [https://registry.terraform.io/providers/hashicorp/hcp/latest/docs]
- Can reference my sample Terraform configuration files and replace your preferred values at variables.tf file as per official documentation [https://github.com/yeemon4398/aws-mini-infra-using-tfc-cli-driven-workflow]
<br>

### Apply Terraform configuration to the AWS cloud using TFC ###
#### 1. Add example code as .tf file under the Terraform configuration project directory as per CLI-driven runs ####
- Command - ```vi backend.tf```
- Contents - as per CLI-driven runs

#### 2. Add environment variables for AWS Access Key ID and Secret Access Key ####
- At TFC, previously created workspace > Variables > Create 2 environment variables
- AWS_ACCESS_KEY_ID < Access Key ID from AWS IAM user
- AWS_SECRET_ACCESS_KEY < Secret Access Key from AWS IAM user

#### 2. Initialize the Terraform ####
- Command - ```terraform init```

#### 3. Plan ####
- Command - ```terraform plan```

#### 4. If plan is succeed, apply ####
- Command - ```terraform apply```

### Monitor triggers at TFC ###
#### 1. Confirm & apply from TFC ####
- Click button of **Confirm & apply**

#### 2. If apply is succeed, Terraform state file will also be found at TFC ####
- At TFC, previously created workspace > States

### Verify resources at the AWS Cloud ###
- Can check my mini infrastructure at VERIFY_AWS_MINI_INFRA.md file
- Can check my EC2 instances nature at VERIFY_EC2_INSTANCES.md file

### Clean up resources ###
- From the CLI, command - ```terraform destroy```
- From the TFC, TFC > Organization > Workspace > Settings > Destruction and Deletion > Queue destroy plan
