import pulumi
import pulumi_aws as aws

terraform_state = aws.s3.BucketV2("terraform_state",
    bucket="terraformstateyabx",
    force_destroy=False,
    tags={
        "Name": "Terraform State Bucket",
        "Environment": "Dev",
    })
this = aws.s3.BucketVersioningV2("this",
    bucket=terraform_state.id,
    versioning_configuration={
        "status": "Enabled",
    })
this_bucket_server_side_encryption_configuration_v2 = aws.s3.BucketServerSideEncryptionConfigurationV2("this",
    bucket=terraform_state.id,
    rules=[{
        "apply_server_side_encryption_by_default": {
            "sse_algorithm": "AES256",
        },
    }])
this_bucket_lifecycle_configuration_v2 = aws.s3.BucketLifecycleConfigurationV2("this",
    bucket=terraform_state.id,
    rules=[{
        "id": "prevent-destroy",
        "status": "Enabled",
        "abort_incomplete_multipart_upload": {
            "days_after_initiation": 7,
        },
    }])
