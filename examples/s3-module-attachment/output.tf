# S3 OUTPUTS
output "PROJECT_NAME" {
  description = "The project name that will be prefixed to resource names"
  value       = module.s3_bucket.PROJECT_NAME
}

output "CREATE_BUCKET" {
  description = "To control if S3 bucket should be created"
  value       = module.s3_bucket.CREATE_BUCKET
}

output "CONTENT_BUCKET" {
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length"
  value       = module.s3_bucket.CONTENT_BUCKET
}

output "CONTENT_BUCKET_FORCE_DESTROY" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  value       = module.s3_bucket.CONTENT_BUCKET_FORCE_DESTROY
}

output "BUCKET_ACL" {
  description = "The canned ACL to apply. Conflicts with 'grant'"
  value       = module.s3_bucket.BUCKET_ACL
}

output "BLOCK_PUBLIC_ACLS" {
  description = "To define wether Amazon S3 should block public ACLs for this bucket"
  value       = module.s3_bucket.BLOCK_PUBLIC_ACLS
}

output "BLOCK_PUBLIC_POLICY" {
  description = "To define whether Amazon S3 should block public bucket policies for this bucket"
  value       = module.s3_bucket.BLOCK_PUBLIC_POLICY
}

output "IGNORE_PUBLIC_ACLS" {
  description = "To define whether Amazon S3 should ignore public ACLs for this bucket"
  value       = module.s3_bucket.IGNORE_PUBLIC_ACLS
}

output "RESTRICT_PUBLIC_BUCKETS" {
  description = "To define whether Amazon S3 should restrict public bucket policies for this bucket"
  value       = module.s3_bucket.RESTRICT_PUBLIC_BUCKETS
}

output "SERVER_SIDE_ENCRYPTION_CONFIGURATION" {
  description = "Server-side encryption configuration"
  value       = module.s3_bucket.SERVER_SIDE_ENCRYPTION_CONFIGURATION
}

output "LOCALS_LIFECYCLE_RULES" {
  description = "List of maps containing configuration of object lifecycle management to be assigned on Locals"
  value       = module.s3_bucket.LOCALS_LIFECYCLE_RULES
}

# CENTRALIZED LOGS OUTPUTS           
output "LOGS_BUCKET_NAME" {
  description = "Name from an existing bucket which will store the application's logs"
  value       = module.centralized_logs.LOGS_BUCKET_NAME
}

output "LOGS_BUCKET_ARN" {
  description = "ARN from an existing bucket which will store the application's logs"
  value       = module.centralized_logs.LOGS_BUCKET_ARN
}

output "ENVIRONMENT" {
  description = "Project Environment"
  value       = module.centralized_logs.ENVIRONMENT
}

output "ATHENA_DIRECTORY_QUERY_PREFIX" {
  description = "Prefix for Athena's query logs"
  value       = module.centralized_logs.ATHENA_DIRECTORY_QUERY_PREFIX
}

output "ATHENA_WORKGROUP_LOGS_STATE" {
  description = "For setting the Athena Workgroup's state"
  value       = module.centralized_logs.ATHENA_WORKGROUP_LOGS_STATE
}

output "KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION" {
  description = "For setting the data destination"
  value       = module.centralized_logs.KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION
}

output "KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX" {
  description = "For setting the suffix on the extended s3 configuration"
  value       = module.centralized_logs.KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX
}

output "KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX" {
  description = "For setting the error output prefix on the extended s3 configuration"
  value       = module.centralized_logs.KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX
}

output "BUFFERING_INTERVAL_IN_SECONDS" {
  description = "Buffer interval in seconds"
  value       = module.centralized_logs.BUFFERING_INTERVAL_IN_SECONDS
}

output "BUFFERING_SIZE_IN_MBS" {
  description = "Buffer size in MBs"
  value       = module.centralized_logs.BUFFERING_SIZE_IN_MBS
}

output "GLUE_CRAWLER_SCHEDULE" {
  description = "Cron Expression for Glue Crawler's schedule"
  value       = module.centralized_logs.GLUE_CRAWLER_SCHEDULE
}

output "GLUE_DB_NAME" {
  description = "Glue database name"
  value       = module.centralized_logs.GLUE_DB_NAME
}

output "POLICY_STATEMENT_ACTION" {
  description = "Block of additional actions for Kinesis Roles"
  value       = module.centralized_logs.POLICY_STATEMENT_ACTION
}
