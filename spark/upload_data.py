import argparse
import boto3
from pathlib import Path


def upload_file(s3_uri: str, local_path: str):
    if not s3_uri.startswith("s3://"):
        raise ValueError("s3_uri must start with s3://")

    _, _, rest = s3_uri.partition("s3://")
    bucket, _, key_prefix = rest.partition("/")
    key = (
        key_prefix.rstrip("/") + "/" + Path(local_path).name
        if key_prefix
        else Path(local_path).name
    )

    s3 = boto3.client("s3")
    s3.upload_file(local_path, bucket, key)
    print(f"Uploaded {local_path} -> s3://{bucket}/{key}")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--raw_s3", required=True, help="e.g., s3://my-raw-bucket/")
    parser.add_argument(
        "--scripts_s3", required=True, help="e.g., s3://my-scripts-bucket/"
    )
    args = parser.parse_args()

    upload_file(args.raw_s3.rstrip("/") + "/", "data/sample_dataset.csv")
    upload_file(args.scripts_s3.rstrip("/") + "/spark/", "spark/etl_job.py")


if __name__ == "__main__":
    main()
