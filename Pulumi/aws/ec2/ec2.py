import pulumi
import pulumi_aws as aws
import pulumi_std as std

id_rsa = aws.ec2.KeyPair("id_rsa",
    key_name=key_name,
    public_key=public_key,
    tags={
        "Name": "kubernate_key_pair",
    })
    
public_instances = []
def create_public_instances(range_body):
    for range in [{"key": k, "value": v} for [k, v] in enumerate(range_body)]:
        public_instances.append(aws.ec2.Instance(f"public_instances-{range['key']}",
            ami=ami,
            instance_type=aws.ec2.InstanceType(instance_type),
            subnet_id=kubernate_vpc["publicSubnetIds"],
            vpc_security_group_ids=[ec2_master_node_sg["sgId"]],
            associate_public_ip_address=False,
            key_name=id_rsa.key_name,
            monitoring=True,
            disable_api_termination=False,
            ebs_optimized=True,
            root_block_device={
                "volume_size": 30,
                "volume_type": "gp2",
                "delete_on_termination": True,
            },
            ebs_block_devices=[{
                "device_name": "/dev/sdh",
                "volume_size": 100,
                "volume_type": "gp2",
                "delete_on_termination": True,
            }],
            tags={
                "Name": f"ec2-{range['key']}",
            },
            opts = pulumi.ResourceOptions(depends_on=[
                    ec2_master_node_sg,
                    kubernate_vpc,
                ])))

std.toset_output(input=["public-ec2-instance"]).apply(lambda resolved_outputs: create_public_instances(resolved_outputs['invoke'].result))

# Optional Elastic IP attachment if enabled
elastic_ip = []
for range in [{"value": i} for i in range(0, 1 if assign_elastic_ip else 0)]:
    elastic_ip.append(aws.ec2.Eip(f"elastic_ip-{range['value']}",
        instance=public_instances["public-ec2-instance"],
        tags={
            "Name": "Elastic IP public for EC2 Instance",
        }))



private_instances = []
def create_private_instances(range_body):
    for range in [{"key": k, "value": v} for [k, v] in enumerate(range_body)]:
        private_instances.append(aws.ec2.Instance(f"private_instances-{range['key']}",
            ami=ami,
            instance_type=aws.ec2.InstanceType(instance_type),
            subnet_id=kubernate_vpc["publicSubnetIds"],
            vpc_security_group_ids=[ec2_worker_node_sg["sgId"]],
            associate_public_ip_address=False,
            key_name=id_rsa.key_name,
            monitoring=True,
            disable_api_termination=False,
            ebs_optimized=True,
            ebs_block_devices=[{
                "device_name": "/dev/sdh",
                "volume_size": 10,
                "volume_type": "gp2",
                "delete_on_termination": True,
            }],
            tags={
                "Name": f"ec2-{range['key']}",
            }))

std.toset_output(input=[
    "private-ec2-instance-1",
    "private-ec2-instance-2",
]).apply(lambda resolved_outputs: create_private_instances(resolved_outputs['invoke'].result))
