# Centralized Logs Module by 7Clouds

Thank you for riding with us! Feel free to download or reference this respository in your terraform projects and studies

This module is a part of our product SCA — An automated API and Serverless Infrastructure generator that can reduce your API development time by 40-60% and automate your deployments up to 90%! Check it out at <https://seventechnologies.cloud>

Please rank this repo 5 starts if you like our job!

## What do we mean by Centralized Logs?

This solution allows you to get, manage and store logs from an application. It might serve as an alternative to Amazon CloudWatch, if you just use it for logging or they might be used concurrently

## How does it work?

1. Kinesis resources set stores the application logs (as get requests for example) in a S3 Bucket
2. Glue transforms your log entries into a data catalog that can be further queried
3. Athena references Glue data catalogs and enables advanced query capabilities on log stored data
4. You now have an economic way to manage and store your logs and three different ways to access them, directly in the S3 Bucket, in the GlueDB and also via Athena

## Diagram

![Amazon AWS Resources Set Diagram for Kinesis, Glue DB, Athena and Bucket for storing logs](https://user-images.githubusercontent.com/106110465/195728293-12d8c5b6-957c-4d71-9b01-2574d9086821.png "7Clouds Centralized Logs Infrastructure")

## Usage

* A configured S3 bucket is required for running this module correctly. It must be set to receive kinesis logs from applications like Lambda Function, ECS/Kubernetes Workload, etc
* This bucket's ID and ARN are requirements for this module's successful deployment
* We have a S3 Bucket module available, you may check it's usage along with the present module in the "s3-module-attachment" example

## Small Fix on Version 0.1.1

Added Kinesis Firehose Stream Name as output.

```hcl
module "centralized_logs" {
  source = "../.."

  #Required
  PROJECT_NAME     = "NewModules"
  LOGS_BUCKET_NAME = "Place your bucket name or ID here"
  LOGS_BUCKET_ARN  = "Place your bucket ARN here"

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
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="terraform-aws-lambda-centralized-logs"></a> [terraform-aws-lambda-centralized-logs](#) | ../.. | 0.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_athena_workgroup.athena_workgroup_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_workgroup) | resource |
| [aws_glue_catalog_database.glue_database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |
| [aws_glue_crawler.glue_crawler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler) | resource |
| [aws_iam_role.glue_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.kinesis_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_kinesis_firehose_delivery_stream.kinesis_firehose_delivery_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ATHENA_DIRECTORY_QUERY_PREFIX"></a> [ATHENA\_DIRECTORY\_QUERY\_PREFIX](#input\_ATHENA\_DIRECTORY\_QUERY\_PREFIX) | Prefix for Athena's query logs | `string` | `"centralized_logs_query_result_files"` | no |
| <a name="input_ATHENA_WORKGROUP_LOGS_STATE"></a> [ATHENA\_WORKGROUP\_LOGS\_STATE](#input\_ATHENA\_WORKGROUP\_LOGS\_STATE) | For setting the Athena Workgroup's state | `string` | `"ENABLED"` | no |
| <a name="input_BUFFERING_INTERVAL_IN_SECONDS"></a> [BUFFERING\_INTERVAL\_IN\_SECONDS](#input\_BUFFERING\_INTERVAL\_IN\_SECONDS) | Buffer interval in seconds | `number` | `60` | no |
| <a name="input_BUFFERING_SIZE_IN_MBS"></a> [BUFFERING\_SIZE\_IN\_MBS](#input\_BUFFERING\_SIZE\_IN\_MBS) | Buffer size in MBs | `number` | `5` | no |
| <a name="input_ENVIRONMENT"></a> [ENVIRONMENT](#input\_ENVIRONMENT) | Project Environment | `string` | `""` | no |
| <a name="input_GLUE_CRAWLER_SCHEDULE"></a> [GLUE\_CRAWLER\_SCHEDULE](#input\_GLUE\_CRAWLER\_SCHEDULE) | Cron Expression for Glue Crawler's schedule | `string` | `"cron(0 12 * * ? *)"` | no |
| <a name="input_GLUE_DB_NAME"></a> [GLUE\_DB\_NAME](#input\_GLUE\_DB\_NAME) | Glue database name | `string` | `"glue_database"` | no |
| <a name="input_KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION"></a> [KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_DESTINATION](#input\_KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_DESTINATION) | For setting the data destination | `string` | `"extended_s3"` | no |
| <a name="input_KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX"></a> [KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_ERROR\_OUTPUT\_SUFFIX](#input\_KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_ERROR\_OUTPUT\_SUFFIX) | For setting the error output prefix on the extended s3 configuration | `string` | `"/!{firehose:random-string}/!{firehose:error-output-type}/!{timestamp:yyyy/MM/dd}/"` | no |
| <a name="input_KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX"></a> [KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_SUFFIX](#input\_KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_SUFFIX) | For setting the suffix on the extended s3 configuration | `string` | `"/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/"` | no |
| <a name="input_LOGS_BUCKET_ARN"></a> [LOGS\_BUCKET\_ARN](#input\_LOGS\_BUCKET\_ARN) | ARN from an existing bucket which will store the application's logs | `string` | n/a | yes |
| <a name="input_LOGS_BUCKET_NAME"></a> [LOGS\_BUCKET\_NAME](#input\_LOGS\_BUCKET\_NAME) | Name from an existing bucket which will store the application's logs | `string` | n/a | yes |
| <a name="input_POLICY_STATEMENT_ACTION"></a> [POLICY\_STATEMENT\_ACTION](#input\_POLICY\_STATEMENT\_ACTION) | Block of additional actions for Kinesis Roles | `list(any)` | `[]` | no |
| <a name="input_PROJECT_NAME"></a> [PROJECT\_NAME](#input\_PROJECT\_NAME) | The project name that will be prefixed to resource names | `string` | `""` | no |
| <a name="input_TAGS"></a> [TAGS](#input\_TAGS) | Tag List | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ATHENA_DIRECTORY_QUERY_PREFIX"></a> [ATHENA\_DIRECTORY\_QUERY\_PREFIX](#output\_ATHENA\_DIRECTORY\_QUERY\_PREFIX) | Prefix for Athena's query logs |
| <a name="output_ATHENA_WORKGROUP_LOGS_STATE"></a> [ATHENA\_WORKGROUP\_LOGS\_STATE](#output\_ATHENA\_WORKGROUP\_LOGS\_STATE) | For setting the Athena Workgroup's state |
| <a name="output_BUFFERING_INTERVAL_IN_SECONDS"></a> [BUFFERING\_INTERVAL\_IN\_SECONDS](#output\_BUFFERING\_INTERVAL\_IN\_SECONDS) | Buffer interval in seconds |
| <a name="output_BUFFERING_SIZE_IN_MBS"></a> [BUFFERING\_SIZE\_IN\_MBS](#output\_BUFFERING\_SIZE\_IN\_MBS) | Buffer size in MBs |
| <a name="output_ENVIRONMENT"></a> [ENVIRONMENT](#output\_ENVIRONMENT) | Project Environment |
| <a name="output_GLUE_CRAWLER_SCHEDULE"></a> [GLUE\_CRAWLER\_SCHEDULE](#output\_GLUE\_CRAWLER\_SCHEDULE) | Cron Expression for Glue Crawler's schedule |
| <a name="output_GLUE_DB_NAME"></a> [GLUE\_DB\_NAME](#output\_GLUE\_DB\_NAME) | Glue database name |
| <a name="output_KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION"></a> [KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_DESTINATION](#output\_KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_DESTINATION) | For setting the data destination |
| <a name="output_KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX"></a> [KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_ERROR\_OUTPUT\_SUFFIX](#output\_KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_ERROR\_OUTPUT\_SUFFIX) | For setting the error output prefix on the extended s3 configuration |
| <a name="output_KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX"></a> [KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_SUFFIX](#output\_KINESIS\_FIREHOSE\_DELIVERY\_STREAM\_SUFFIX) | For setting the suffix on the extended s3 configuration |
| <a name="output_LOGS_BUCKET_ARN"></a> [LOGS\_BUCKET\_ARN](#output\_LOGS\_BUCKET\_ARN) | ARN from an existing bucket which will store the application's logs |
| <a name="output_LOGS_BUCKET_NAME"></a> [LOGS\_BUCKET\_NAME](#output\_LOGS\_BUCKET\_NAME) | Name from an existing bucket which will store the application's logs |
| <a name="output_POLICY_STATEMENT_ACTION"></a> [POLICY\_STATEMENT\_ACTION](#output\_POLICY\_STATEMENT\_ACTION) | Block of additional actions for Kinesis Roles |
| <a name="output_PROJECT_NAME"></a> [PROJECT\_NAME](#output\_PROJECT\_NAME) | The project name that will be prefixed to resource names |
| <a name="output_TAGS"></a> [TAGS](#output\_TAGS) | Tag List |
<!-- END_TF_DOCS -->