resource "aws_athena_workgroup" "athena_workgroup_logs" {
  description = "AthenaWorkgroup for centralized logs test."
  name        = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME}AthenaWorkgroup" : "AthenaWorkgroup"
  state       = var.ATHENA_WORKGROUP_LOGS_STATE
  configuration {
    result_configuration {
      output_location = "s3://${var.LOGS_BUCKET_NAME}/${var.ATHENA_DIRECTORY_QUERY_PREFIX}/"
    }
  }
  tags = var.TAGS != null ? "${
    merge(var.TAGS, {
      Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} Athena WorkGroup" : "Athena WorkGroup" }
    )}" : {
    Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} Athena WorkGroup" : "Athena WorkGroup"
  }
}

resource "aws_iam_role" "kinesis_role" {
  name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME}KinesisRole" : "KinesisRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "firehose.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME}KinesisPolicy" : "KinesisPolicy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "s3:AbortMultipartUpload",
            "s3:GetBucketLocation",
            "s3:GetObject",
            "s3:ListBucket",
            "s3:ListBucketMultipartUploads",
            "s3:PutObject"
          ]
          Effect = "Allow"
          Resource = ["${var.LOGS_BUCKET_ARN}",
            "${var.LOGS_BUCKET_ARN}/*"
          ]
        },
        {
          Action = "${concat(var.POLICY_STATEMENT_ACTION, [
            "kinesis:DescribeStream",
            "kinesis:GetShardIterator",
            "kinesis:GetRecords",
            "kinesis:ListShards",
            "kms:Decrypt",
            "kms:GenerateDataKey",
            "logs:PutLogEvents"])}"
          Effect   = "Allow"
          Resource = ["*"]
        },
      ]
    })
  }
  tags = var.TAGS != null ? "${
    merge(var.TAGS, {
      Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} Kinesis Role" : "Kinesis Role" }
    )}" : {
    Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} Kinesis Role" : "Kinesis Role"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehose_delivery_stream" {
  name        = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME}KinesisFireHoseDeliveryStream" : "KinesisFireHoseDeliveryStream"
  destination = var.KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION
  extended_s3_configuration {
    bucket_arn          = var.LOGS_BUCKET_ARN
    prefix              = var.ENVIRONMENT != "" ? "logs/${var.ENVIRONMENT}${var.KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX}" : "logs${var.KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX}"
    error_output_prefix = var.ENVIRONMENT != "" ? "logs/${var.ENVIRONMENT}${var.KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX}" : "logs${var.KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX}"
    role_arn            = aws_iam_role.kinesis_role.arn
    buffering_interval     = var.BUFFERING_INTERVAL_IN_SECONDS
    buffering_size         = var.BUFFERING_SIZE_IN_MBS
  }
  tags = var.TAGS != null ? "${
    merge(var.TAGS, {
      Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} Kinesis FireHose Delivery Stream" : "Kinesis FireHose Delivery Stream" }
    )}" : {
    Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} Kinesis FireHose Delivery Stream" : "Kinesis FireHose Delivery Stream"
  }
}

resource "aws_glue_catalog_database" "glue_database" {
  name = var.GLUE_DB_NAME
}

resource "aws_iam_role" "glue_role" {
  name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME}GlueRole" : "GlueRole"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "glue.amazonaws.com"
          }
      }]
  })
  inline_policy {
    name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME}GluePolicy" : "GluePolicy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["s3:*"]
          Effect = "Allow"
          Resource = ["${var.LOGS_BUCKET_ARN}",
            "${var.LOGS_BUCKET_ARN}/*"
          ]
        },
        {
          Action   = ["glue:*", "logs:*"]
          Effect   = "Allow"
          Resource = ["*"]
        }
      ]
    })
  }
  tags = var.TAGS != null ? "${
    merge(var.TAGS, {
      Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} Kinesis Role" : "Kinesis Role" }
    )}" : {
    Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} Kinesis Role" : "Kinesis Role"
  }
}

resource "aws_glue_crawler" "glue_crawler" {
  name          = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME}GlueCrawler" : "GlueCrawler"
  role          = aws_iam_role.glue_role.arn
  schedule      = var.GLUE_CRAWLER_SCHEDULE
  database_name = aws_glue_catalog_database.glue_database.name
  s3_target {
    path = "s3://${var.LOGS_BUCKET_NAME}/logs"
  }
  tags = var.TAGS != null ? "${
    merge(var.TAGS, {
      Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} Glue Crawler" : "Glue Crawler" }
    )}" : {
    Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} Glue Crawler" : "Glue Crawler"
  }
}