import pulumi_gcp as gcp
from config import config
from .vpc import vpc
import pulumi

if config["enable_nat_gateway"]:
    router = gcp.compute.Router("nat-router", region=config["region"], network=vpc.id)

    nat = gcp.compute.RouterNat("cloud-nat",
        router=router.name,
        region=config["region"],
        nat_ip_allocate_option="AUTO_ONLY",
        source_subnetwork_ip_ranges_to_nat="ALL_SUBNETWORKS_ALL_IP_RANGES",
    )
    pulumi.export("nat_router_name", router.name)
    pulumi.export("nat_name", nat.name)
else:
    pulumi.export("nat_gateway_enabled", False)
    pulumi.export("nat_router_name", None)
    pulumi.export("nat_name", None)  