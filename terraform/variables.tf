variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "aws-lakehouse-spark-platform"
}

variable "env" {
  type    = string
  default = "dev"
}

# Optional: set a globally-unique bucket prefix (recommended)
variable "bucket_prefix" {
  type        = string
  description = "Globally unique prefix for S3 buckets (e.g., yourname-lakehouse-123)."
}

variable "glue_job_name" {
  type    = string
  default = "lakehouse-spark-etl"
}

variable "glue_worker_type" {
  type    = string
  default = "G.1X"
}

variable "glue_number_of_workers" {
  type    = number
  default = 2
}