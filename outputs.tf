output "kms_key_arn" {
  value = aws_kms_key.fintech_key.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.payment_events.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.transactions.name
}

output "lambda_function_name" {
  value = aws_lambda_function.process_payment_lambda.function_name
}
