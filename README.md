# aws-lakehouse-spark-platform
Designed and implemented a cloud-native lakehouse architecture on AWS using Terraform and Spark to process, optimize, and analyze large-scale datasets

1. Architecture Overview
   
                +--------------------+
                |  External Dataset  |
                | (CSV / JSON files) |
                +---------+----------+
                          |
                          v
                  S3 Bucket (RAW)
                  s3://lakehouse/raw/
                          |
                          v
                Spark ETL Processing
               (EMR / Glue / Spark)
                          |
                          v
                 S3 Bucket (PROCESSED)
               s3://lakehouse/processed/
                          |
                          v
                 S3 Bucket (CURATED)
                s3://lakehouse/curated/
                          |
                          v
                     Athena Query
                          |
                          v
                       BI Tools
