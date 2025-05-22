############################################################################################
#                                      ESSENTIAL                                           #
############################################################################################
variable "PROJECT_NAME" {
  description = "The project name that will be prefixed to resource names"
  type        = string
}

variable "LOGS_BUCKET_NAME" {
  description = "Name from an existing bucket which will store the application's logs"
  type        = string
}

variable "LOGS_BUCKET_ARN" {
  description = "ARN from an existing bucket which will store the application's logs"
  type        = string
}

############################################################################################
#                                      OPTIONAL                                            #
############################################################################################

variable "ENVIRONMENT" {
  description = "Project Environment"
  type        = string
  default     = ""
}

variable "ATHENA_DIRECTORY_QUERY_PREFIX" {
  type        = string
  description = "Prefix for Athena's query logs"
  default     = "centralized_logs_query_result_files"
}

variable "ATHENA_WORKGROUP_LOGS_STATE" {
  type        = string
  description = "For setting the Athena Workgroup's state"
  default     = "ENABLED"
}

variable "KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION" {
  type        = string
  description = "For setting the data destination"
  default     = "extended_s3"
}

variable "KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX" {
  type        = string
  description = "For setting the suffix on the extended s3 configuration"
  default     = "/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/"
}

variable "KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX" {
  type        = string
  description = "For setting the error output prefix on the extended s3 configuration"
  default     = "/!{firehose:random-string}/!{firehose:error-output-type}/!{timestamp:yyyy/MM/dd}/"
}

variable "BUFFERING_INTERVAL_IN_SECONDS" {
  type        = number
  description = "Buffer interval in seconds"
  default     = 60
}

variable "BUFFERING_SIZE_IN_MBS" {
  type        = number
  description = "Buffer size in MBs"
  default     = 5
}

variable "GLUE_CRAWLER_SCHEDULE" {
  type        = string
  description = "Cron Expression for Glue Crawler's schedule"
  default     = "cron(0 12 * * ? *)"
}

variable "GLUE_DB_NAME" {
  type        = string
  description = "Glue database name"
  default     = "glue_database"
}

variable "POLICY_STATEMENT_ACTION" {
  type        = list(any)
  description = "Block of additional actions for Kinesis Roles"
  default     = []
}

variable "TAGS" {
  type        = map(string)
  description = "Tag List"
  default     = null
}

variable "firehose_s3_kms_key_arn" {
  description = "Optional Customer Managed KMS key ARN for server-side encryption of data delivered to S3 by Firehose. If not provided, data will be encrypted using an AWS S3-managed key (SSE-S3/AES256 by default for the extended_s3 destination)."
  type        = string
  default     = null
}

variable "firehose_stream_kms_key_arn" {
  description = "Optional Customer Managed KMS key ARN to enable and use for Kinesis Data Firehose stream encryption. If not provided, stream encryption with a customer key is disabled."
  type        = string
  default     = null
}