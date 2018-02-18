# Workaround, allowing interpolation in variables
locals {
  azs = "${var.AWS_REGION}a,${var.AWS_REGION}b"
}
