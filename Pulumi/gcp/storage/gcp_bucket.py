import pulumi_gcp as gcp
from config import config
import pulumi

bucket = gcp.storage.Bucket("terraform-state-bucket",
    location=config["region"],
    versioning=gcp.storage.BucketVersioningArgs(enabled=True),
    force_destroy=False,
    uniform_bucket_level_access=True,
    lifecycle_rules=[gcp.storage.BucketLifecycleRuleArgs(
        action=gcp.storage.BucketLifecycleRuleActionArgs(type="AbortIncompleteMultipartUpload"),
        condition=gcp.storage.BucketLifecycleRuleConditionArgs(age=7),
    )]
)

pulumi.export("bucket_name", bucket.url)