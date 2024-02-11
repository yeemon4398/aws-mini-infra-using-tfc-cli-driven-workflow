variable "aws_region" {
  description = "Preferred AWS region to build infrastructure"
  type        = string
  default     = "ap-southeast-1"
}

variable "my_vpc_cidr" {
  description = "Preferred CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_sub01_cidr" {
  description = "Preferred CIDR block based on defined VPC's CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_sub02_cidr" {
  description = "Preferred CIDR block based on defined VPC's CIDR block"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_sub03_cidr" {
  description = "Preferred CIDR block based on defined VPC's CIDR block"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_sub01_cidr" {
  description = "Preferred CIDR block based on defined VPC's CIDR block"
  type        = string
  default     = "10.0.4.0/24"
}

variable "private_sub02_cidr" {
  description = "Preferred CIDR block based on defined VPC's CIDR block"
  type        = string
  default     = "10.0.5.0/24"
}

variable "private_sub03_cidr" {
  description = "Preferred CIDR block based on defined VPC's CIDR block"
  type        = string
  default     = "10.0.6.0/24"
}

variable "specific_cidr" {
  description = "Preferred specific CIDR block"
  type        = string
  default     = "0.0.0.0/0"
}

variable "sub01_az" {
  description = "Preferred availability zone based on choosen region"
  type        = string
  default     = "ap-southeast-1a"
}

variable "sub02_az" {
  description = "Preferred availability zone based on choosen region"
  type        = string
  default     = "ap-southeast-1b"
}

variable "sub03_az" {
  description = "Preferred availability zone based on choosen region"
  type        = string
  default     = "ap-southeast-1c"
}

variable "ami_id" {
  description = "Preferred AMI ID"
  type        = string
  default     = "ami-0fa377108253bf620" # Ubuntu 22.04 AMI ID
}

variable "inst_type" {
  description = "Preferred instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair" {
  description = "Preferred SSH key pair"
  type        = string
  default     = "my_keypair" # Used existing key on my AWS account
}