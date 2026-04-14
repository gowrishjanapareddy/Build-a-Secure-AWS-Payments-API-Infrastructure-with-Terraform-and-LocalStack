# Project Submission Guide: Secure Payments Infrastructure

This project implements a secure, event-driven serverless payments API using Terraform and LocalStack.

## 💰 Cost Information
- **Local Testing**: **FREE**. Using LocalStack with Docker ensures no charges are incurred.
- **AWS Deployment**: This project is designed to stay within the **AWS Free Tier**.
    - **KMS**: $1/month per key (standard KMS cost outside free tier).
    - **S3/DynamoDB/Lambda**: Well within monthly free tier limits for typical testing.

## 🛡️ Privacy & Security
- **No Secrets**: All hardcoded account IDs (e.g., `000000000000`) and access keys are **LocalStack defaults** and are safe for public repositories.
- **Encryption**: Data is encrypted at rest in both S3 and DynamoDB using KMS.
- **Least Privilege**: IAM policies are scoped specifically to the resources created.

## 🎥 Video Verification Commands
Use these commands in order for your submission video to demonstrate a successful deployment:

### 1. Start Environment
```powershell
# Ensure Docker is running first
docker-compose up -d
```

### 2. Initialize & Deploy
```powershell
# Use the local terraform executable
.\terraform.exe init
.\terraform.exe workspace select dev 
.\terraform.exe apply -auto-approve
```

### 3. Verify Security (Compliance)
```powershell
# Verify S3 Encryption
aws --endpoint-url=http://localhost:4566 s3api get-bucket-encryption --bucket fintech-payment-events-dev --no-cli-pager

# Verify S3 Public Access Block
aws --endpoint-url=http://localhost:4566 s3api get-public-access-block --bucket fintech-payment-events-dev --no-cli-pager

# Verify DynamoDB Encryption
aws --endpoint-url=http://localhost:4566 dynamodb describe-table --table-name transactions-dev --no-cli-pager
```

### 4. Demonstrate Functional Flow
```powershell
# 1. Create a test payment
'{"id":"demo-1","amount":50}' > test.json

# 2. Upload to S3 (triggers Lambda)
aws --endpoint-url=http://localhost:4566 s3 cp test.json s3://fintech-payment-events-dev/

# 3. Check DynamoDB for the processed record
aws --endpoint-url=http://localhost:4566 dynamodb scan --table-name transactions-dev --no-cli-pager
```
