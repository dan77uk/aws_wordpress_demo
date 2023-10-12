# Public Route Table
resource "aws_route_table" "Public_SubNet_RouteTable" {
  depends_on = [aws_internet_gateway.igw]
  vpc_id     = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public Route Table"
  }
}

# Private Route Tables
resource "aws_route_table" "az_A__Private_SubNet_RouteTable" {
  depends_on = [aws_nat_gateway.wordpress[0]]
  vpc_id     = aws_vpc.main.id
  tags = {
    Name = "${var.azs[0]} Private Route Table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.wordpress[0].id
  }
}

resource "aws_route_table" "az_B__Private_SubNet_RouteTable" {
  depends_on = [aws_nat_gateway.wordpress[1]]

  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.azs[1]} Private Route Table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.wordpress[1].id
  }
}

# Association for Public Subnets
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.Public_SubNet_RouteTable.id
}
# Association for Private App Subnets (AZ A)
resource "aws_route_table_association" "azA_private_application_subnet_association" {
  subnet_id      = aws_subnet.private_subnets_application[0].id
  route_table_id = aws_route_table.az_A__Private_SubNet_RouteTable.id
}
# Association for Private App Subnets (AZ B)
resource "aws_route_table_association" "azB_private_application_subnet_association" {
  subnet_id      = aws_subnet.private_subnets_application[1].id
  route_table_id = aws_route_table.az_B__Private_SubNet_RouteTable.id
}
