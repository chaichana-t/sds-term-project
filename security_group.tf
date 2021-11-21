resource "aws_security_group" "public" {
    name   = "public"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "local"
        from_port   = 0
        to_port     = 0
        protocol    = "all"
        self        = true
    }

    ingress {
        description = "http"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "https"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "wildcard"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "private_instance" {
    name   = "private_instance"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "local"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        self        = true
    }

    egress {
        description = "wildcard"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "private_database" {
    name   = "private_database"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "local"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        self        = true
    }

    egress {
        description = "wildcard"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
