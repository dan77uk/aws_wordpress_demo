resource "aws_subnet" "public_subnets" {
  depends_on              = [aws_vpc.main]
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.azs[count.index]} Public Subnet" }
}

# Private App Subnets
resource "aws_subnet" "private_subnets_application" {
  depends_on        = [aws_vpc.main]
  count             = length(var.private_application_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_application_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags              = { Name = "${var.azs[count.index]} Private App Subnet" }
}

# Private Data Subnets for RDS
resource "aws_subnet" "private_subnets_data" {
  depends_on        = [aws_vpc.main]
  count             = length(var.private_data_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_data_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags              = { Name = "${var.azs[count.index]} Private Data Subnet" }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "wordpress-demo--rds--subnet-group"
  subnet_ids = aws_subnet.private_subnets_data[*].id
}
