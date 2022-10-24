output "PROJECT_NAME" {
  description = "The project name that will be prefixed to resource names"
  value       = var.PROJECT_NAME
}

output "ENVIRONMENT" {
  description = "Project Environment"
  value       = var.ENVIRONMENT
}

output "ATHENA_DIRECTORY_QUERY_PREFIX" {
  description = "Prefix for Athena's query logs"
  value       = var.ATHENA_DIRECTORY_QUERY_PREFIX
}

output "ATHENA_WORKGROUP_LOGS_STATE" {
  description = "For setting the Athena Workgroup's state"
  value       = var.ATHENA_WORKGROUP_LOGS_STATE
}

output "KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION" {
  description = "For setting the data destination"
  value       = var.KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION
}

output "LOGS_BUCKET_NAME" {
  description = "Name from an existing bucket which will store the application's logs"
  value       = var.LOGS_BUCKET_NAME
}

output "LOGS_BUCKET_ARN" {
  description = "ARN from an existing bucket which will store the application's logs"
  value       = var.LOGS_BUCKET_ARN
}

output "KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX" {
  description = "For setting the suffix on the extended s3 configuration"
  value       = var.KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX
}

output "KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX" {
  description = "For setting the error output prefix on the extended s3 configuration"
  value       = var.KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX
}

output "BUFFERING_INTERVAL_IN_SECONDS" {
  description = "Buffer interval in seconds"
  value       = var.BUFFERING_INTERVAL_IN_SECONDS
}

output "BUFFERING_SIZE_IN_MBS" {
  description = "Buffer size in MBs"
  value       = var.BUFFERING_SIZE_IN_MBS
}

output "GLUE_CRAWLER_SCHEDULE" {
  description = "Cron Expression for Glue Crawler's schedule"
  value       = var.GLUE_CRAWLER_SCHEDULE
}

output "GLUE_DB_NAME" {
  description = "Glue database name"
  value       = var.GLUE_DB_NAME
}

output "POLICY_STATEMENT_ACTION" {
  description = "Block of additional actions for Kinesis Roles"
  value       = var.POLICY_STATEMENT_ACTION
}

output "TAGS" {
  description = "Tag List"
  value       = var.TAGS
}