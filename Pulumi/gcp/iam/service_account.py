import pulumi_gcp as gcp
from config import config
import pulumi
#create a sample iam service account
service_account = gcp.serviceaccount.Account(
    "my-service-account",
    account_id="my-service-account",
    display_name="My Service Account"
)

pulumi.export("service_account_email", service_account.email)
pulumi.export("service_account_name", service_account.name)
pulumi.export("service_account_display_name", service_account.display_name)
