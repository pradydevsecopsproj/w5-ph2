resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  # tags = merge(var.tags, { Name = "${var.environment_name}-vpc" })
  tags = merge(local.common_tags, { Name = "${var.environment_name}-vpc-prady" })
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  # tags = merge(var.tags, { Name = "${var.environment_name}-igw" })
  tags = merge(local.common_tags, { Name = "${var.environment_name}-igw-prady" })
}

resource "aws_subnet" "public" {
  for_each                = { for idx, az in local.azs : az => local.public_subnets[idx] }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.environment_name}-public-${each.key}-prady"
  })
}

# Kept on hold on the private subnet for demo since required EIP and NAT gateway
# resource "aws_subnet" "private" {
#   for_each = { for idx, az in local.azs : az => local.private_subnets[idx] }
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = each.value
#   availability_zone = each.key
#   tags = merge(var.tags, {
#     Name = "${var.environment_name}-private-${each.key}"
#   })
# }

# resource "aws_eip" "nat" {
#   tags = merge(var.tags, { Name = "${var.environment_name}-nat-eip" })
# }

# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = values(aws_subnet.public)[0].id
#   tags = merge(var.tags, { Name = "${var.environment_name}-nat" })
#   depends_on = [aws_internet_gateway.igw]
# }

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0" // Need to check if MY IP restricittion to apply
    gateway_id = aws_internet_gateway.igw.id
  }
  # tags = merge(var.tags, { Name = "${var.environment_name}-public-rt" })
  tags = merge(local.common_tags, { Name = "${var.environment_name}-public-rt-prady" })
}

resource "aws_route_table_association" "public_rt_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}
# Kept on hold on the private subnet and aws_route_table and associations
# resource "aws_route_table" "private_rt" {
#   vpc_id = aws_vpc.main.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat.id
#   }
#   tags = merge(var.tags, { Name = "${var.environment_name}-private-rt" })
# }

# resource "aws_route_table_association" "private_rt_assoc" {
#   for_each = aws_subnet.private
#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.private_rt.id
# }
