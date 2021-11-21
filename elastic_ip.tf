resource "aws_eip" "app" {
    vpc               = true
    network_interface = aws_network_interface.app_public.id

    depends_on = [
        aws_internet_gateway.internet_gateway
    ]
}

resource "aws_eip" "database" {
    vpc = true
}

output "nextcloud_ip" {
    value = aws_instance.app.public_ip
}
