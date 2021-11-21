resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        "Name" = "${var.app}_internet_gateway"
    }
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.database.id
    subnet_id     = aws_subnet.public.id
    
    tags = {
        "Name" : "${var.app}_nat_gateway"
    }
}
