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


2. Project Folder Structure

                                                              cloud-lakehouse-platform
                                                              │
                                                              ├── terraform
                                                              │   ├── main.tf
                                                              │   ├── variables.tf
                                                              │   ├── backend.tf
                                                              │   ├── iam.tf
                                                              │   ├── s3.tf
                                                              │   ├── emr.tf
                                                              │   └── outputs.tf
                                                              │
                                                              ├── spark
                                                              │   └── etl_job.py
                                                              │
                                                              ├── data
                                                              │   └── sample_dataset.csv
                                                              │
                                                              ├── scripts
                                                              │   └── upload_data.py
                                                              │
                                                              └── README.md
