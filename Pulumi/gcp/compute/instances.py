import pulumi_gcp as gcp
from config import config
import pulumi
import networking.vpc as networking_vpc

static_ip = gcp.compute.Address(
    "master-static-ip",
    region=config["region"]
)
# Example: Create a master instance without specifying a custom service account
master_instance = gcp.compute.Instance(
    "master-instance",
    machine_type=config["machine_type"],
    zone=config["zone"],
    boot_disk=gcp.compute.InstanceBootDiskArgs(
        initialize_params=gcp.compute.InstanceBootDiskInitializeParamsArgs(
            image=config["image_family"]
        )
    ),
    network_interfaces=[gcp.compute.InstanceNetworkInterfaceArgs(
        network=networking_vpc.vpc.id,
        subnetwork=networking_vpc.public_subnet.id,
        access_configs=[gcp.compute.InstanceNetworkInterfaceAccessConfigArgs(
            nat_ip=static_ip.address
        )]
    )],
    metadata={
        "ssh-keys": "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEbkhW9gr0iRMzd2fV0If8ru7Dx0+rr2LYE+Zu8/m8XPz4P61QCig/SaKeU4t/VCTVqTDeqR5TLGCiCSysfkuKydMyr3ixN7gs6I8Ngw9uApWhjrGrKJRdz5sP8E2KOlqEG9yZXDYRLRVY7x1Lzqjs26X7g8/jp0xZGcMZetdMdIjoVVd2nz/EHN2gSB94jZI8kHZTFpx1jjQkosr4veDxKiGsMtPfE4fqlvDze3TkiYw71gx9u5K3ZYXXqArVE0CkThBcyh6UBnTRSwOlRUGiuyZRaMjg1sNwLBzYmLVFB3kdx4ae3po6TieghWwtYfVN8eaHjMZL+vTVWMBnudN1 universal-key"
    },
    tags=["master"]
)

pulumi.export("master_instance_name", master_instance.name)
pulumi.export("master_static_ip", static_ip.address)

