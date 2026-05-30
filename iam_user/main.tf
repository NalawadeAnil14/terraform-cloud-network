resource "aws_iam_user" "first_user" {
  name = var.name
  path = "/system/"

  tags = {
    User = var.name
  }
}
