import sys
from datetime import datetime

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, lit, to_date, year, month, dayofmonth


def get_arg(name: str, default: str = None) -> str:
    # Glue passes args like --KEY value
    if f"--{name}" in sys.argv:
        idx = sys.argv.index(f"--{name}")
        return sys.argv[idx + 1]
    if default is None:
        raise ValueError(f"Missing required argument: --{name}")
    return default


def main():
    raw_s3 = get_arg("RAW_S3")
    processed_s3 = get_arg("PROCESSED_S3")
    curated_s3 = get_arg("CURATED_S3")

    spark = SparkSession.builder.appName("lakehouse-etl").getOrCreate()
    spark.sparkContext.setLogLevel("INFO")

    # Example input paths
    raw_csv_path = raw_s3.rstrip("/") + "/sample_dataset.csv"

    # 1) Ingest RAW (CSV/JSON)
    df = (
        spark.read.option("header", "true")
        .option("inferSchema", "true")
        .csv(raw_csv_path)
    )

    # 2) Clean / standardize
    # Expecting columns: id, category, amount, event_date
    # event_date as YYYY-MM-DD
    df_clean = (
        df.withColumn("ingested_at", lit(datetime.utcnow().isoformat()))
        .withColumn("event_date", to_date(col("event_date")))
        .filter(col("event_date").isNotNull())
        .filter(col("amount").isNotNull())
    )

    # 3) Write PROCESSED as partitioned Parquet (good for Athena)
    df_processed = (
        df_clean.withColumn("year", year(col("event_date")))
        .withColumn("month", month(col("event_date")))
        .withColumn("day", dayofmonth(col("event_date")))
    )

    processed_out = processed_s3.rstrip("/") + "/events/"
    (
        df_processed.repartition(col("year"), col("month"))  # helps partition layout
        .write.mode("overwrite")
        .partitionBy("year", "month", "day")
        .parquet(processed_out)
    )

    # 4) CURATED: example aggregation for BI (category totals by month)
    curated_out = curated_s3.rstrip("/") + "/category_monthly_totals/"

    df_curated = (
        df_processed.groupBy("category", "year", "month")
        .sum("amount")
        .withColumnRenamed("sum(amount)", "total_amount")
    )

    (
        df_curated.repartition(col("year"), col("month"))
        .write.mode("overwrite")
        .partitionBy("year", "month")
        .parquet(curated_out)
    )

    spark.stop()


if __name__ == "__main__":
    main()
