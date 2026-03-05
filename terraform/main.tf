provider "aws" {
  region = var.region
}

locals {
  name = "${var.project_name}-${var.env}"

  raw_bucket      = "${var.bucket_prefix}-raw"
  processed_bucket = "${var.bucket_prefix}-processed"
  curated_bucket  = "${var.bucket_prefix}-curated"
  scripts_bucket  = "${var.bucket_prefix}-scripts"
  athena_bucket   = "${var.bucket_prefix}-athena-results"

  glue_db_name    = replace(local.name, "-", "_")
}