resource "aws_s3_bucket" "enabled_via_object" {
  bucket = "test-bucket"
  acl    = "private"
  versioning {
    enabled = true
  }
  object_lock_configuration = {
    object_lock_enabled = "Enabled"
  }
}