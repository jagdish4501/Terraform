import pulumi
import pulumi_aws as aws

main = aws.ec2.Vpc("main",
    cidr_block=vpc_cidr,
    enable_dns_support=enable_dns_support,
    enable_dns_hostnames=enable_dns_hostnames,
    tags={
        "Name": vpc_name,
    })
public_subnets = []
for range in [{"value": i} for i in range(0, len(public_subnet_cidr_block))]:
    public_subnets.append(aws.ec2.Subnet(f"public_subnets-{range['value']}",
        vpc_id=main.id,
        cidr_block=public_subnet_cidr_block[range["value"]],
        availability_zone=public_subnet_azs[range["value"]],
        map_public_ip_on_launch=True,
        tags={
            "Name": f"public_subnet_{vpc_name}_{public_subnet_cidr_block[range['value']]}",
        }))
private_subnets = []
for range in [{"value": i} for i in range(0, len(private_subnet_cidr_block))]:
    private_subnets.append(aws.ec2.Subnet(f"private_subnets-{range['value']}",
        vpc_id=main.id,
        cidr_block=private_subnet_cidr_block[range["value"]],
        availability_zone=private_subnet_azs[range["value"]],
        map_public_ip_on_launch=False,
        tags={
            "Name": f"private_subnet_{vpc_name}_{private_subnet_cidr_block[range['value']]}",
        }))
internet_gateway = aws.ec2.InternetGateway("internet_gateway",
    vpc_id=main.id,
    tags={
        "Name": f"internet_gateway_{vpc_name}",
    })
elastic_ip = []
for range in [{"value": i} for i in range(0, 1 if enable_nat_gateway else 0)]:
    elastic_ip.append(aws.ec2.Eip(f"elastic_ip-{range['value']}", tags={
        "Name": f"elastic_ip_{vpc_name}",
    }))
nat_gateway = []
for range in [{"value": i} for i in range(0, 1 if enable_nat_gateway else 0)]:
    nat_gateway.append(aws.ec2.NatGateway(f"nat_gateway-{range['value']}",
        subnet_id=public_subnets[0].id,
        allocation_id=elastic_ip[0].id,
        tags={
            "Name": f"nat_gateway_{vpc_name}",
        },
        opts = pulumi.ResourceOptions(depends_on=[elastic_ip])))
public_route_table = aws.ec2.RouteTable("public_route_table",
    vpc_id=main.id,
    routes=[{
        "cidr_block": "0.0.0.0/0",
        "gateway_id": internet_gateway.id,
    }],
    tags={
        "Name": f"public_route_table_{vpc_name}",
    })
private_route_table = aws.ec2.RouteTable("private_route_table",
    routes=[{
        "cidr_block": "0.0.0.0/0",
        "nat_gateway_id": nat_gateway[0].id,
    } for entry in [{"key": k, "value": v} for k, v in [1] if enable_nat_gateway else []]],
    vpc_id=main.id,
    tags={
        "Name": f"private_route_table_{vpc_name}",
    })
public_route_table_association_with_subnet = []
for range in [{"value": i} for i in range(0, len(public_subnet_cidr_block))]:
    public_route_table_association_with_subnet.append(aws.ec2.RouteTableAssociation(f"public_route_table_association_with_subnet-{range['value']}",
        subnet_id=public_subnets[range["value"]].id,
        route_table_id=public_route_table.id,
        opts = pulumi.ResourceOptions(depends_on=[
                public_subnets,
                public_route_table,
            ])))
private_route_table_association_with_subnet = []
for range in [{"value": i} for i in range(0, len(private_subnet_cidr_block))]:
    private_route_table_association_with_subnet.append(aws.ec2.RouteTableAssociation(f"private_route_table_association_with_subnet-{range['value']}",
        subnet_id=private_subnets[range["value"]].id,
        route_table_id=private_route_table.id,
        opts = pulumi.ResourceOptions(depends_on=[
                private_subnets,
                private_route_table,
            ])))
