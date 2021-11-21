resource "aws_instance" "app" {
  ami               = var.ami
  # ami               = data.aws_ami.ubuntu.id
  availability_zone = var.availability_zone
  instance_type     = var.instance_type
  user_data         = data.template_file.nextcloud_user_data.rendered
  
  network_interface {
    network_interface_id = aws_network_interface.app_public.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.app_private.id
    device_index         = 1
  }

  tags = {
    "Name" = "${var.app}_app"
  }
}

resource "aws_instance" "database" {
  ami               = var.ami
  # ami               = data.aws_ami.ubuntu.id
  availability_zone = var.availability_zone
  instance_type     = var.instance_type
  user_data         = data.template_file.database_user_data.rendered
  
  network_interface {
    network_interface_id = aws_network_interface.database_nat.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.database_private.id
    device_index         = 1
  }

  tags = {
    "Name" = "${var.app}_database"
  }
}
