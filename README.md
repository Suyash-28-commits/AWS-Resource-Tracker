# AWS Resource Tracker

A lightweight Bash automation script that audits and reports on key AWS resources in your account using the AWS CLI.

---

## Author

**Suyash Das**
Version: v1 | Date: 26th May, 2026

---

## Overview

This script provides a quick inventory of the following AWS resources:

| Resource | Description |
|----------|-------------|
| **S3 Buckets** | Lists all S3 buckets in the account |
| **EC2 Instances** | Extracts and displays all EC2 Instance IDs |
| **Lambda Functions** | Lists all deployed Lambda functions |
| **IAM Users** | Lists all IAM users in the account |

---

## Prerequisites

Before running the script, ensure the following are installed and configured:

### 1. AWS CLI
Install the AWS CLI by following the [official guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

```bash
aws --version
# Expected: aws-cli/2.x.x ...
```

### 2. `jq`
Used to parse JSON output from the AWS CLI.

```bash
# Ubuntu/Debian
sudo apt-get install jq

# macOS
brew install jq
```

### 3. AWS Credentials
Configure your AWS credentials with sufficient permissions:

```bash
aws configure
```

You will be prompted for:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., `us-east-1`)
- Output format (e.g., `json`)

---

## Required IAM Permissions

The IAM user or role running this script must have the following permissions:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    { "Effect": "Allow", "Action": "s3:ListAllMyBuckets", "Resource": "*" },
    { "Effect": "Allow", "Action": "ec2:DescribeInstances",  "Resource": "*" },
    { "Effect": "Allow", "Action": "lambda:ListFunctions", "Resource": "*" },
    { "Effect": "Allow", "Action": "iam:ListUsers", "Resource": "*" }
  ]
}
```

---

## Usage

### 1. Clone or download the script

```bash
git clone https://github.com/Suyash-28-commits/<your-repo>.git
cd <your-repo>
```

### 2. Make it executable

```bash
chmod +x aws_resource_tracker.sh
```

### 3. Run it

```bash
./aws_resource_tracker.sh
```

---

## Sample Output

```
+ echo 'List of s3 buckets'
List of s3 buckets
2026-01-10 12:00:00 my-project-bucket
2026-03-22 09:30:00 backup-bucket

+ echo 'List of ec2 instances'
List of ec2 instances
"i-0abc123def456789a"
"i-0xyz987fed654321b"

+ aws lambda list-functions
{
  "Functions": [
    { "FunctionName": "my-lambda-fn", "Runtime": "python3.11", ... }
  ]
}

+ aws iam list-users
{
  "Users": [
    { "UserName": "suyash-admin", "UserId": "AIDA...", ... }
  ]
}
```

> **Note:** The `set -x` flag at the top of the script enables debug mode, printing each command before it executes. This is useful for tracing but can be removed for cleaner output in production.

---

## Script Breakdown

```bash
set -x                          # Enable debug/trace mode
aws s3 ls                       # List all S3 buckets
aws ec2 describe-instances \
  | jq '.Reservations[].Instances[].InstanceId'   # Extract EC2 Instance IDs
aws lambda list-functions       # List all Lambda functions
aws iam list-users              # List all IAM users
```

---

## Customisation

| Goal | How |
|------|-----|
| Filter EC2 by region | Add `--region <region>` to the `aws ec2` command |
| Save output to a file | Run `./aws_resource_tracker.sh > report.txt 2>&1` |
| Remove debug output | Delete or comment out `set -x` |
| Add more resources | Extend with `aws rds describe-db-instances`, `aws vpc describe-vpcs`, etc. |

---

## Future Improvements

- [ ] Accept AWS region as a CLI argument
- [ ] Output results in JSON or CSV format
- [ ] Add SNS notification support to email the report
- [ ] Integrate with a cron job for scheduled audits
- [ ] Add error handling for missing credentials or insufficient permissions

---

## License

This project is open-source and available under the [MIT License](LICENSE).
