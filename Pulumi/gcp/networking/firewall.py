import pulumi_gcp as gcp
from config import config
from .vpc import vpc
import pulumi

gcp.compute.Firewall("master-node-fw",
    network=vpc.id,
    allows=[gcp.compute.FirewallAllowArgs(
        protocol="tcp",
        ports=["22", "6443", "10250"],
    )],
    direction="INGRESS",
    source_ranges=["0.0.0.0/0"],
)

gcp.compute.Firewall("worker-node-fw",
    network=vpc.id,
    allows=[gcp.compute.FirewallAllowArgs(
        protocol="tcp",
        ports=["22", "10250"],
    )],
    direction="INGRESS",
    source_ranges=["0.0.0.0/0"],
)
gcp.compute.Firewall("internal-communication-fw",
    network=vpc.id,
    allows=[gcp.compute.FirewallAllowArgs(
        protocol="tcp",
        ports=["10250", "30000-32767"],
    )],
    direction="INGRESS",
    source_ranges=["10.0.0.0/8"],
)

pulumi.export("master_node_firewall", "master-node-fw")
pulumi.export("worker_node_firewall", "worker-node-fw")
pulumi.export("internal_communication_firewall", "internal-communication-fw")
pulumi.export("firewall_rules", {
    "master_node": "master-node-fw",
    "worker_node": "worker-node-fw",
    "internal_communication": "internal-communication-fw"
})


