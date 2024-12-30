provider "aws" {
  region = var.region
}
resource "aws_vpc" "ies-vpc" {
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "ies-vpc"
    }
}

//  ===============================
resource "aws_internet_gateway" "ies-igw" {
  vpc_id = aws_vpc.ies-vpc.id
  tags = {
    Name = "ies-igw"
  }
}

//  =================================
resource "aws_subnet" "public_subnet_1" {
   vpc_id = aws_vpc.ies-vpc.id
   cidr_block  = var.public_subnet_ies[0]
   availability_zone = var.availability_zones_a
   tags = {
     Name = "ies-public-subnet-1"
   }    
}

//  ==================================
resource "aws_subnet" "public_subnet_2" {
   vpc_id = aws_vpc.ies-vpc.id
   cidr_block  = var.public_subnet_ies[1]
   availability_zone = var.availability_zones_b
   tags = {
     Name = "ies-public-subnet-2"
   }    
}

// =================================
resource "aws_subnet" "private_subnet_1" {
   vpc_id = aws_vpc.ies-vpc.id
   cidr_block = var.private_subnet_ies[0]
   availability_zone = var.availability_zones_a
   tags = {
     Name = "ies-private-subnet_1"
   }    
}

// ==================================
resource "aws_subnet" "private_subnet_2" {
   vpc_id = aws_vpc.ies-vpc.id
   cidr_block = var.private_subnet_ies[1]
   availability_zone = var.availability_zones_b
   tags = {
     Name = "ies-private-subnet_2"
   }    
}

// ===================================
resource "aws_route_table" "ies-public-route-table" {
  vpc_id = aws_vpc.ies-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ies-igw.id
  }
  tags = {
    Name = "ies-public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.ies-public-route-table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id 
  route_table_id = aws_route_table.ies-public-route-table.id
}

// ===================================
resource "aws_route_table" "ies-private-route-table" {
  vpc_id = aws_vpc.ies-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id  =  module.bastion_nat.network_interface_id
  }

  tags = {
    Name = "ies-private-route-table"
  }
}

resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.ies-private-route-table.id

}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id 
  route_table_id = aws_route_table.ies-private-route-table.id
}
