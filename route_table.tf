resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      "Name" = "${var.app}_public"
    }
}

resource "aws_route" "public" {
    route_table_id         = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public" {
    route_table_id = aws_route_table.public.id
    subnet_id      = aws_subnet.public.id
}

resource "aws_route_table" "private_database" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      "Name" = "${var.app}_private_database"
    }
}

resource "aws_route" "private_database" {
    route_table_id         = aws_route_table.private_database.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table_association" "private_database" {
    route_table_id = aws_route_table.private_database.id
    subnet_id      = aws_subnet.private_database.id
}