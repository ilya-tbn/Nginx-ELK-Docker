#VPC Creation
resource "aws_vpc" "awesomeVpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"    
    tags = {
        Name = "awesomeVpc"
    }
}
#Subnet creation under awesomeVpc
resource "aws_subnet" "subnet-10-0-101" {
    vpc_id = aws_vpc.awesomeVpc.id
    cidr_block = "10.0.101.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = var.awsAZ
    tags = {
        Name = "docker-101"
    }
}
#Internet gateway and routing table so that we could access the instances on this subnet from the internet
 resource "aws_internet_gateway" "docker-igw" {
     vpc_id = aws_vpc.awesomeVpc.id
     tags = {
         Name = "docker-igw"
     }
 }
 resource "aws_route_table" "docker-route-table" {
     vpc_id = aws_vpc.awesomeVpc.id
     route {
         cidr_block = "0.0.0.0/0" 
         gateway_id = aws_internet_gateway.docker-igw.id
     }
     tags = {
         Name = "docker-route-table"
     }
 }
 resource "aws_route_table_association" "docker-routetableassoc"{
     subnet_id = aws_subnet.subnet-10-0-101.id
     route_table_id = aws_route_table.docker-route-table.id
 }

#Security group (Access List) for our Docker instance. it will allow access from the Docker to anywhere and access to the Nginx,Kibana, and SSH access.
resource "aws_security_group" "docker-sg" {
    vpc_id = aws_vpc.awesomeVpc.id
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["YOUR_IP_ADDRESS_HERE/32"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["YOUR_IP_ADDRESS_HERE/32"]
    }
    ingress {
        from_port = 5601
        to_port = 5601
        protocol = "tcp"
        cidr_blocks = ["YOUR_IP_ADDRESS_HERE/32"]
    }
    tags = {
        Name = "NGINX-SSH-KIBANA"
    }
}
#Create an elastic IP address.
resource "aws_eip" "dockerEip" {
  vpc = true
}
