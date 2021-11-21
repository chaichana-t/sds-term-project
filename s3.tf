resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.bucket_name}-${var.region}"
  acl           = "private"
  force_destroy = true

  tags = {
    "Name" = "${var.app}_bucket"
  }
}

resource "aws_iam_user" "bucket" {
  name = "${var.app}_bucket"
  path = "/nextcloud/"
}

data "aws_iam_policy_document" "bucket" {
  statement {
    actions   = ["s3:*", "s3-object-lambda:*"]
    resources = [ aws_s3_bucket.bucket.arn,"${aws_s3_bucket.bucket.arn}/*"]
    effect    = "Allow"
  }
  statement {
    actions = [
                "kms:Decrypt",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext",
                "kms:GenerateDataKeyPairWithoutPlaintext",
                "kms:GenerateDataKeyPair"
              ]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "bucket" {
    name   = "${var.app}_bucket"
    policy = data.aws_iam_policy_document.bucket.json  
}

resource "aws_iam_user_policy_attachment" "attachment" {
  user       = aws_iam_user.bucket.name
  policy_arn = aws_iam_policy.bucket.arn
}

resource "aws_iam_access_key" "bucket" {
  user = aws_iam_user.bucket.name
}
