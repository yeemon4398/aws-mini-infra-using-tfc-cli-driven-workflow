# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = var.my_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "my_vpc"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}

# Create an Elastic IP for NAT Gateway
resource "aws_eip" "nat_gw_eip" {
  domain = "vpc"
  tags = {
    Name = "nat_gw_eip"
  }
}

# Create a NAT Gateway
resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet_01.id
  tags = {
    Name = "my_nat_gw"
  }
  depends_on = [aws_internet_gateway.my_igw]
}

# Add 3 public subnets
resource "aws_subnet" "public_subnet_01" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_sub01_cidr
  availability_zone       = var.sub01_az
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_01"
  }
}

resource "aws_subnet" "public_subnet_02" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_sub02_cidr
  availability_zone       = var.sub02_az
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_02"
  }
}

resource "aws_subnet" "public_subnet_03" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_sub03_cidr
  availability_zone       = var.sub03_az
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_03"
  }
}

# Add 3 private subnets
resource "aws_subnet" "private_subnet_01" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_sub01_cidr
  availability_zone       = var.sub01_az
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_01"
  }
}

resource "aws_subnet" "private_subnet_02" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_sub02_cidr
  availability_zone       = var.sub02_az
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_02"
  }
}

resource "aws_subnet" "private_subnet_03" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_sub03_cidr
  availability_zone       = var.sub03_az
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_03"
  }
}

# Add a route table for public subnets
resource "aws_route_table" "my_public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_public_route_table"
  }
}

# Add a route table for private subnets
resource "aws_route_table" "my_private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_private_route_table"
  }
}

# Add a route table for private subnets but need to go Internet
resource "aws_route_table" "my_private_rt_internet" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_private_rt_internet"
  }
}

# Add a route for public route table to the Internet using IGW
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.my_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

# Add a route for private route table to the Internet using NAT GW
resource "aws_route" "private_internet_route" {
  route_table_id         = aws_route_table.my_private_rt_internet.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.my_nat_gw.id
}

# Associate public subnets with public route table
resource "aws_route_table_association" "publicsn01rt" {
  subnet_id      = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.my_public_route_table.id
}

resource "aws_route_table_association" "publicsn02rt" {
  subnet_id      = aws_subnet.public_subnet_02.id
  route_table_id = aws_route_table.my_public_route_table.id
}

resource "aws_route_table_association" "publicsn03rt" {
  subnet_id      = aws_subnet.public_subnet_03.id
  route_table_id = aws_route_table.my_public_route_table.id
}

# Associate private subnets with private route table  but need to go Internet
resource "aws_route_table_association" "privatesn01rt" {
  subnet_id      = aws_subnet.private_subnet_01.id
  route_table_id = aws_route_table.my_private_rt_internet.id
}

# Associate private subnets with private route table
resource "aws_route_table_association" "privatesn02rt" {
  subnet_id      = aws_subnet.private_subnet_02.id
  route_table_id = aws_route_table.my_private_route_table.id
}

resource "aws_route_table_association" "privatesn03rt" {
  subnet_id      = aws_subnet.private_subnet_03.id
  route_table_id = aws_route_table.my_private_route_table.id
}

# Create 2 EC2 instances in the public subnets
resource "aws_instance" "my_public_instance01" {
  ami                    = var.ami_id
  instance_type          = var.inst_type
  key_name               = var.key_pair
  subnet_id              = aws_subnet.public_subnet_01.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_from_specific_nw.id]
  tags = {
    Name = "my_public_instance01"
  }
}

resource "aws_instance" "bastion_host" {
  ami                    = var.ami_id
  instance_type          = var.inst_type
  key_name               = var.key_pair
  subnet_id              = aws_subnet.public_subnet_02.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_from_specific_nw.id]
  tags = {
    Name = "bastion_host"
  }
}

# Create 2 EC2 instances in the public subnets
resource "aws_instance" "my_private_instance01" {
  ami                    = var.ami_id
  instance_type          = var.inst_type
  key_name               = var.key_pair
  subnet_id              = aws_subnet.private_subnet_01.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_from_bastion_host.id]
  tags = {
    Name = "my_private_instance01"
  }
}

resource "aws_instance" "my_private_db_instance" {
  ami                    = var.ami_id
  instance_type          = var.inst_type
  key_name               = var.key_pair
  subnet_id              = aws_subnet.private_subnet_02.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_from_bastion_host.id]
  tags = {
    Name = "my_private_db_instance"
  }
}

# Create a security group for my_private_db_instance to be able to access from bastion_host
resource "aws_security_group" "allow_ssh_from_bastion_host" {
  name        = "allow_ssh_from_bastion_host"
  description = "Allow SSH traffic from only bastion_host"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "allow_ssh_from_bastion_host"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_sub02_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for instances to be able to access from specific network
resource "aws_security_group" "allow_ssh_from_specific_nw" {
  name        = "allow_ssh_from_specific_nw"
  description = "Allow SSH traffic from specific network"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "allow_ssh_from_specific_nw"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.specific_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}