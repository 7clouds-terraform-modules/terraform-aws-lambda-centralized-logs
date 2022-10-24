# 7Clouds Terraform AWS S3 Module for Centralized Logs Attachment

## Usage

This example calls our S3 Bucket module along with our Centralized Logs module. This configuration for the bucket fills all the requirements for a successful deployment

```hcl
module "s3_bucket" {
  source  = "7clouds-terraform-modules/s3-bucket/aws"
  version = "0.1.0"

  PROJECT_NAME                 = "NewModules"
  CREATE_BUCKET                = true
  CONTENT_BUCKET               = "sandbox-s3-01"
  CONTENT_BUCKET_FORCE_DESTROY = true
  BUCKET_ACL                   = "private"
  BLOCK_PUBLIC_ACLS            = true
  BLOCK_PUBLIC_POLICY          = true
  IGNORE_PUBLIC_ACLS           = true
  RESTRICT_PUBLIC_BUCKETS      = true
  SERVER_SIDE_ENCRYPTION_CONFIGURATION = {
    rule = {
      apply_server_side_encryption_by_default = {
      sse_algorithm = "AES256"
      }
  }
}
  LOCALS_LIFECYCLE_RULES = [
    {
      id     = "a8b0f5724a7211edb8780242ac120002"
      status = "Enabled"
      filter = {
        prefix = ""
      }
      expiration = {
        days = 30
      }
    },
    {
      id     = "b8b0f5724a7211edb8780242ac110003"
      status = "Enabled"
      filter = {
        prefix = "centralized_logs_query_result_files"
      }
      expiration = {
        days = 1
      }
    }
  ]
}

module "centralized_logs" {
  source = "../.."

  #Required
  PROJECT_NAME     = "NewModules"
  LOGS_BUCKET_NAME = module.s3_bucket.CONTENT_BUCKET
  LOGS_BUCKET_ARN  = module.s3_bucket.BUCKET_ARN

  #Optionals
  ENVIRONMENT                                          = "dev"
  ATHENA_DIRECTORY_QUERY_PREFIX                        = "centralized_logs_query_result_files"
  ATHENA_WORKGROUP_LOGS_STATE                          = "ENABLED"
  KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION         = "extended_s3"
  KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX              = "/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/"
  KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX = "/!{firehose:random-string}/!{firehose:error-output-type}/!{timestamp:yyyy/MM/dd}/"
  BUFFERING_INTERVAL_IN_SECONDS                        = 60
  BUFFERING_SIZE_IN_MBS                                = 5
  GLUE_CRAWLER_SCHEDULE                                = "cron(0 12 * * ? *)"
  GLUE_DB_NAME                                         = "new_modules_glue_database_1234567890"
  POLICY_STATEMENT_ACTION                              = ["lambda:InvokeFunction",
                                                          "lambda:GetFunctionConfiguration"]
  TAGS                                                 = null

  depends_on = [module.s3_bucket]
}
```
