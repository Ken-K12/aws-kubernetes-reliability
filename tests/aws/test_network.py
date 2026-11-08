import os

import boto3
import pytest

AWS_REGION = os.getenv("AWS_REGION", "us-east-1")
VPC_ID = os.getenv("VPC_ID")

@pytest.fixture(scope="module")
def ec2_client():
    return boto3.client("ec2", region_name=AWS_REGION)

def test_vpc_exists_and_is_available(ec2_client):
    assert VPC_ID, "VPC_ID environment variable is not set"

    response = ec2_client.describe_vpcs(VpcIds=[VPC_ID])
    vpcs = response.get("Vpcs", [])
 
    assert vpcs, f"VPC with ID {VPC_ID} does not exist"
 
    vpc = vpcs[0]
 
    assert vpc["State"] == "available", f"VPC with ID {VPC_ID} is not available"

def test_vpc_has_multiple_subnets(ec2_client):
    assert VPC_ID, "VPC_ID environment variable is not set"

    response = ec2_client.describe_subnets(
        Filters=[
            {
                "Name": "vpc-id", 
                "Values": [VPC_ID]
            }
        ]
    )
    subnets = response.get("Subnets", [])

    assert subnets, f"No subnets found for VPC with ID {VPC_ID}"
    assert len(subnets) >= 2, f"VPC with ID {VPC_ID} does not have multiple subnets"