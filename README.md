
# aws-lakehouse-spark-platform

A cloud-native data lakehouse platform built on AWS using Terraform and Apache Spark to ingest, process, optimize, and analyze large-scale datasets.

The platform follows a modern lakehouse architecture using layered storage:

- Raw Layer – stores original datasets
- Processed Layer – cleansed and optimized datasets
- Curated Layer – analytics-ready data for BI and querying

Technologies used:

- AWS S3
- AWS Glue / Spark
- AWS Athena
- Terraform
- Python
- Parquet data format

---

# 1. Architecture Overview

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

This architecture enables:

- scalable data ingestion
- distributed Spark processing
- optimized Parquet storage
- serverless analytics using Athena

---

# 2. Project Folder Structure

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

---

# 3. Prerequisites

Before running the project, ensure the following tools are installed:

- AWS CLI
- Terraform >= 1.6
- Python 3.9+
- An AWS account with appropriate permissions

Configure AWS credentials:

aws configure

Verify configuration:

aws sts get-caller-identity

---

# 4. Deploy Infrastructure (Terraform)

Navigate to the Terraform directory.

cd terraform

Initialize Terraform:

terraform init

Review the infrastructure plan:

terraform plan

Deploy the infrastructure:

terraform apply

Terraform provisions:

- S3 buckets (raw / processed / curated)
- IAM roles and policies
- Spark processing infrastructure
- Athena query environment

---

# 5. Upload Sample Dataset

Return to the project root:

cd ..

Upload the sample dataset:

python scripts/upload_data.py

This uploads:

sample_dataset.csv → S3 RAW layer

---

# 6. Run Spark ETL Job

Execute the Spark ETL job that transforms raw datasets into optimized Parquet datasets.

aws glue start-job-run --job-name lakehouse-spark-etl

The Spark job performs:

1. Data ingestion from the raw layer
2. Data cleaning and schema normalization
3. Conversion to Parquet format
4. Partitioning by date
5. Writing results to the processed and curated layers

---

# 7. Query Data Using Athena

After the ETL pipeline completes, data in the curated layer can be queried using Athena.

Example SQL query:

SELECT *
FROM curated_table
LIMIT 10;

Athena queries data directly from S3 without requiring database servers.

---

# 8. Example Data Flow

sample_dataset.csv
        │
        ▼
S3 RAW Layer
        │
        ▼
Spark ETL Job
        │
        ▼
Parquet Files (Processed)
        │
        ▼
Curated Data Layer
        │
        ▼
Athena Queries
        │
        ▼
Dashboards / BI Tools

---

# 9. Key Features

- Infrastructure as Code using Terraform
- Distributed ETL processing with Apache Spark
- Lakehouse architecture using S3 layered storage
- Columnar storage with Parquet for efficient analytics
- Serverless SQL querying via AWS Athena
- Fully reproducible and scalable pipeline

---

# 10. Future Improvements

Possible enhancements:

- Glue Data Catalog schema automation
- Incremental ETL pipelines
- Data quality validation
- Partition optimization
- CI/CD deployment pipelines
- Integration with BI tools (QuickSight / Tableau)
