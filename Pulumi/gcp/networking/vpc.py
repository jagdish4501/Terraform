import pulumi_gcp as gcp
from config import config
import pulumi

vpc = gcp.compute.Network(config["vpc_name"], auto_create_subnetworks=False)
public_subnet = gcp.compute.Subnetwork("public-subnet",
    ip_cidr_range=config["public_subnet_cidr_block"][0],
    region=config["region"],
    network=vpc.id,
    private_ip_google_access=False,
)
private_subnets = []
# Create private subnets based on the provided CIDR blocks  
for i, cidr in enumerate(config["private_subnet_cidr_block"]):
    subnet = gcp.compute.Subnetwork(f"private-subnet-{i+1}",
        ip_cidr_range=cidr,
        region=config["region"],
        network=vpc.id,
        private_ip_google_access=True
    )
    private_subnets.append(subnet)

pulumi.export("vpc_id", vpc.id)
pulumi.export("public_subnet_id", public_subnet.id)
pulumi.export("private_subnet_ids", [s.id for s in private_subnets])  
pulumi.export("vpc_name", vpc.name)
pulumi.export("public_subnet_name", public_subnet.name)
pulumi.export("private_subnet_names", [s.name for s in private_subnets])
pulumi.export("public_subnet_cidr_block", public_subnet.ip_cidr_range)
pulumi.export("private_subnet_cidr_blocks", [s.ip_cidr_range for s in private_subnets])   


__all__ = [
    "vpc",
    "public_subnet",
    "private_subnets"
]