resource "aws_network_interface" "app_public" {
    subnet_id       = aws_subnet.public.id
    security_groups = [aws_security_group.public.id]
}

resource "aws_network_interface" "app_private" {
    subnet_id       = aws_subnet.private_instance.id
    security_groups = [aws_security_group.private_instance.id]
    private_ips     = [var.app_private_ip]
}

resource "aws_network_interface" "database_nat" {
    subnet_id       = aws_subnet.private_database.id
    security_groups = [aws_security_group.private_database.id]
}

resource "aws_network_interface" "database_private" {
    subnet_id       = aws_subnet.private_instance.id
    security_groups = [aws_security_group.private_instance.id]
    private_ips     = [var.database_private_ip]
}
