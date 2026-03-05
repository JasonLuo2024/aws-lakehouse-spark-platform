resource "aws_glue_catalog_database" "db" {
  name = local.glue_db_name
}

resource "aws_glue_job" "etl" {
  name     = "${local.name}-${var.glue_job_name}"
  role_arn = aws_iam_role.glue_role.arn

  glue_version = "4.0"
  worker_type  = var.glue_worker_type
  number_of_workers = var.glue_number_of_workers

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://${aws_s3_bucket.scripts.bucket}/spark/etl_job.py"
  }

  default_arguments = {
    "--job-language"                          = "python"
    "--enable-continuous-cloudwatch-log"      = "true"
    "--enable-metrics"                        = "true"
    "--enable-spark-ui"                       = "true"
    "--spark-event-logs-path"                 = "s3://${aws_s3_bucket.athena_results.bucket}/sparkHistory/"
    "--RAW_S3"                                = "s3://${aws_s3_bucket.raw.bucket}/"
    "--PROCESSED_S3"                          = "s3://${aws_s3_bucket.processed.bucket}/"
    "--CURATED_S3"                            = "s3://${aws_s3_bucket.curated.bucket}/"
  }
}

# Crawler to create Athena tables automatically over curated parquet
resource "aws_glue_crawler" "curated" {
  name          = "${local.name}-curated-crawler"
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.db.name

  s3_target {
    path = "s3://${aws_s3_bucket.curated.bucket}/"
  }

  schema_change_policy {
    update_behavior = "UPDATE_IN_DATABASE"
    delete_behavior = "DEPRECATE_IN_DATABASE"
  }
}