module "s3_bucket" {
  source = "github.com/ckv-tests/terraform-aws-s3-bucket-private?ref=v0.0.1"

  acl     = "public"
  enabled = true
}
