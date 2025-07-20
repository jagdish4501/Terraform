from config import config

# Networking
from networking.vpc import vpc, public_subnet, private_subnets
from networking.nat import *
from networking.firewall import *

# Compute
from compute.instances import *

# Storage
from storage.gcp_bucket import *

# Optionally export outputs
import pulumi
pulumi.export("vpc_id", vpc.id)
pulumi.export("public_subnet_id", public_subnet.id)
pulumi.export("private_subnet_ids", [s.id for s in private_subnets])