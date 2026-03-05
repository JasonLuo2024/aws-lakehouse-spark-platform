output "raw_bucket"       { value = aws_s3_bucket.raw.bucket }
output "processed_bucket" { value = aws_s3_bucket.processed.bucket }
output "curated_bucket"   { value = aws_s3_bucket.curated.bucket }
output "scripts_bucket"   { value = aws_s3_bucket.scripts.bucket }
output "athena_results_bucket" { value = aws_s3_bucket.athena_results.bucket }

output "glue_job_name"    { value = aws_glue_job.etl.name }
output "glue_database"    { value = aws_glue_catalog_database.db.name }
output "crawler_name"     { value = aws_glue_crawler.curated.name }
output "region"           { value = var.region }