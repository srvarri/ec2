#!/bin/sh
#create-vpc
aws ec2 create-vpc `
    --region "us-west-1" `
    --cidr-block "10.10.0.0/16" `
    --tag-specification "ResourceType=vpc,Tags=[{Key=Name,Value=MyVpc}]"
#   "VpcId": "vpc-0bdf842eeb4a3193b",  
#create-subnet
aws ec2 create-subnet `
    --region "us-west-1" `
    --availability-zone "us-west-1a" `
    --vpc-id "vpc-0bdf842eeb4a3193b" `
    --cidr-block "10.10.0.0/24" `
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=web}]"
#  "SubnetId": "subnet-087f09322b16f0aed",   
aws ec2 create-route-table `
 --region "us-west-1" `
 --vpc-id "vpc-0bdf842eeb4a3193b" `
 --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=rtweb}]"  
#  "RouteTableId": "rtb-04474e19c63bc233f",
#create associate-routetable
aws ec2 associate-route-table `
 --region "us-west-1" `
 --route-table-id "rtb-04474e19c63bc233f" `
 --subnet-id "subnet-087f09322b16f0aed"  
 #create internet gateway
aws ec2 create-internet-gateway `
 --region "us-west-1" `
 --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=my-igw}]"
# "InternetGatewayId": "igw-01f558b64a9bc7429",
# attch internetgateway
aws ec2 attach-internet-gateway `
 --region "us-west-1" `
 --internet-gateway-id "igw-01f558b64a9bc7429" `
 --vpc-id "vpc-0bdf842eeb4a3193b" 
#create securtiy group
aws ec2 create-security-group `
 --region "us-west-1" `
 --group-name "mysec" `
 --description "My security group" `
 --vpc-id "vpc-0bdf842eeb4a3193b" `
 --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=mysec}]"
# "GroupId": "sg-043f4a9badef48ce2",
#authorized security group port 22
aws ec2 authorize-security-group-ingress `
 --region "us-west-1" `
 --group-id "sg-043f4a9badef48ce2" `
 --protocol "tcp" `
 --port "22" `
 --cidr "10.10.0.0/16" 
# authorized security group port 80
aws ec2 authorize-security-group-ingress `
 --region "us-west-1" `
 --group-id "sg-043f4a9badef48ce2" `
 --protocol "tcp" `
 --port "80" `
 --cidr "10.10.0.0/16"
# authorized security group port all
aws ec2 authorize-security-group-ingress `
 --region "us-west-1" `
 --group-id "sg-043f4a9badef48ce2" `
 --protocol "icmp" `
 --port "all" `
 --cidr "10.10.0.0/16" 
# authorized security group port all
aws ec2 authorize-security-group-ingress `
 --region "us-west-1" `
 --group-id "sg-043f4a9badef48ce2" `
 --protocol "all" `
 --port "0-65535" `
 --cidr "10.10.0.0/16"
#key pair
aws ec2 create-key-pair `
 --region "us-west-1" `
 --key-name mykeypair1 `
 --query 'KeyMaterial' `
 --output text > mykeypair1.pem

#Ec2  
aws ec2 run-instances `
 --region "us-west-1" `
 --image-id "ami-02ea247e531eb3ce6" `
 --count 1 `
 --instance-type t2.micro `
 --key-name mykeypair1 `
 --security-group-ids "sg-043f4a9badef48ce2" `
 --subnet-id "subnet-087f09322b16f0aed" `
 --associate-public-ip-address `
 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=web}]"
 
#"InstanceId": "i-0d43f49694da9df73" 

# delete instance
# aws ec2 terminate-instances `
# --instance-ids "i-0d43f49694da9df73"