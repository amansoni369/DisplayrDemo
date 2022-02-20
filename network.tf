# non default VPC to launch resource 
resource "aws_vpc" "displayr_vpc" {
  cidr_block           = "10.0.0.0/24"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "displayr_asoni-vpc"
  }
}

# create a public subnet
resource "aws_subnet" "displayr_subnet_1" {
  vpc_id            = aws_vpc.displayr_vpc.id
  cidr_block        = "10.0.0.64/26"
  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "displayr_asoni-subnet1"
  }
}

# Add sg rule(s) to default security group
resource "aws_security_group_rule" "displayr_sg_rule_one" {
  type              = "ingress"
  security_group_id = aws_vpc.displayr_vpc.default_security_group_id
  protocol          = "TCP"
  from_port         = "22"
  to_port           = "22"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Default SG to allow SSH into public EC2 instances"
}

resource "aws_security_group_rule" "displayr_sg_rule_two" {
  type              = "ingress"
  security_group_id = aws_vpc.displayr_vpc.default_security_group_id
  protocol          = "TCP"
  from_port         = "80"
  to_port           = "80"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "SG Rule to reach nginx on port 80 in public ec2"
}

# create internet gateway to attach to non-default VPC
resource "aws_internet_gateway" "displayr_igw" {
  vpc_id = aws_vpc.displayr_vpc.id

  tags = {
    Name = "displayr_asoni-igw"
  }
}

# create non-main route table
resource "aws_route_table" "displayr_route_table" {
  vpc_id = aws_vpc.displayr_vpc.id

  tags = {
    Name = "displayr_asoni-rt"
  }
}

# associate public subnet with non-main route table
resource "aws_route_table_association" "tf_demo_rt_association" {
  subnet_id      = aws_subnet.displayr_subnet_1.id
  route_table_id = aws_route_table.displayr_route_table.id
}

# add route to the non-main route table
resource "aws_route" "displayr_route_non_main" {
  route_table_id         = aws_route_table.displayr_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.displayr_igw.id
}
