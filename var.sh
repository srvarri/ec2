#!/bin/bash
#******************************************************************************
#    AWS VPC Creation Shell Script
#******************************************************************************
#==============================================================================
#   MODIFY THE SETTINGS BELOW
#==============================================================================
AWS_REGION="us-west-1"
VPC_NAME="My VPC"
VPC_CIDR="10.0.0.0/16"
SUBNET_PUBLIC_CIDR="10.0.1.0/24"
SUBNET_PUBLIC_AZ="us-west-1a"
SUBNET_PUBLIC_NAME="10.0.1.0 - us-west-1a"
SUBNET_PRIVATE_CIDR="10.0.2.0/24"
SUBNET_PRIVATE_AZ="us-west-1c"
SUBNET_PRIVATE_NAME="10.0.2.0 - us-west-1b"
#==============================================================================
#   DO NOT MODIFY CODE BELOW
#==============================================================================
# Create VPC
echo "Creating VPC in preferred region..."
VPC_ID=$(aws ec2 create-vpc \
  --cidr-block $VPC_CIDR \
  --query 'Vpc.{VpcId:VpcId}' \
  --output text \
  --region $AWS_REGION)
echo "  VPC ID '$VPC_ID' CREATED in '$AWS_REGION' region."
# Add Name tag to VPC
aws ec2 create-tags \
  --resources $VPC_ID \
  --tags "Key=Name,Value=$VPC_NAME" \
  --region $AWS_REGION
echo "  VPC ID '$VPC_ID' NAMED as '$VPC_NAME'."
#create-subnet
# Create Public Subnet
echo "Creating Public Subnet..."
SUBNET_PUBLIC_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PUBLIC_CIDR \
  --availability-zone $SUBNET_PUBLIC_AZ \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_PUBLIC_ID' CREATED in '$SUBNET_PUBLIC_AZ'" \
  "Availability Zone."

# Add Name tag to Public Subnet
aws ec2 create-tags \
  --resources $SUBNET_PUBLIC_ID \
  --tags "Key=Name,Value=$SUBNET_PUBLIC_NAME" \
  --region $AWS_REGION
echo "  Subnet ID '$SUBNET_PUBLIC_ID' NAMED as" \
  "'$SUBNET_PUBLIC_NAME'."
# Create Private Subnet
echo "Creating Private Subnet..."
SUBNET_PRIVATE_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PRIVATE_CIDR \
  --availability-zone $SUBNET_PRIVATE_AZ \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_PRIVATE_ID' CREATED in '$SUBNET_PRIVATE_AZ'" \
  "Availability Zone."

# Add Name tag to Private Subnet
aws ec2 create-tags \
  --resources $SUBNET_PRIVATE_ID \
  --tags "Key=Name,Value=$SUBNET_PRIVATE_NAME" \
  --region $AWS_REGION
echo "  Subnet ID '$SUBNET_PRIVATE_ID' NAMED as '$SUBNET_PRIVATE_NAME'."