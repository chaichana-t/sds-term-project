resource "aws_subnet" "public" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = var.public_subnet
    availability_zone = var.availability_zone

    depends_on = [
        aws_internet_gateway.internet_gateway
    ]
    
    tags = {
        "Name" = "${var.app}_public"
    }
}

resource "aws_subnet" "private_database" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = var.private_database_subnet
    availability_zone = var.availability_zone

    tags = {
        "Name" = "${var.app}_private_database"
    }
}

resource "aws_subnet" "private_instance" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = var.private_instance_subnet
    availability_zone = var.availability_zone

    tags = {
        "Name" = "${var.app}_private_instance"
    }
}
