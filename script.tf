data "template_file" "nextcloud_user_data" {
  template = file("./scripts/app.sh")
  vars = {
    bucket_name   = aws_s3_bucket.bucket.bucket
    key           = aws_iam_access_key.bucket.id
    secret        = aws_iam_access_key.bucket.secret
    region        = var.region
    database      = var.database
    database_name = var.database_name
    database_user = var.database_user
    database_pass = var.database_pass
    database_host = var.database_private_ip
    admin_user    = var.admin_user
    admin_pass    = var.admin_pass
    public_ip     = aws_eip.app.public_ip
  }
}

data "template_file" "database_user_data" {
  template = file("./scripts/database.sh")
  vars = {
    database_user = var.database_user
    database_pass = var.database_pass
    database_name = var.database_name
    app_host      = var.app_private_ip
  }
}
