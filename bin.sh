#!/bin/bash
#create-vpc
aws ec2 create-vpc `
    --region "us-west-2" `
    --cidr-block "10.10.0.0/16" `
    --tag-specification "ResourceType=vpc,Tags=[{Key=Name,Value=MyVpc}]"
#"VpcId": "vpc-06638c2700e798792"    
#create-subnet
aws ec2 create-subnet `
    --region "us-west-2" `
    --availability-zone "us-west-2a" `
    --vpc-id "vpc-06638c2700e798792" `
    --cidr-block "10.10.0.0/24" `
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=web}]"
# "SubnetId": "subnet-068223cdd4fc4ef79"    
aws ec2 create-route-table `
 --region "us-west-2" `
 --vpc-id "vpc-06638c2700e798792" `
 --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=rtweb}]"  
#"RouteTableId": "rtb-018052fdc4c22624c" 
#create associate-routetable
aws ec2 associate-route-table `
 --region "us-west-2" `
 --route-table-id "rtb-018052fdc4c22624c" `
 --subnet-id "subnet-068223cdd4fc4ef79"  
 #create internet gateway
aws ec2 create-internet-gateway `
 --region "us-west-2" `
 --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=my-igw}]"
# "InternetGatewayId": "igw-026c6214f17e377a0"
# attch internetgateway
aws ec2 attach-internet-gateway `
 --region "us-west-2" `
 --internet-gateway-id "igw-026c6214f17e377a0" `
 --vpc-id "vpc-06638c2700e798792" 
#create securtiy group
aws ec2 create-security-group `
 --region "us-west-2" `
 --group-name "mysec" `
 --description "My security group" `
 --vpc-id "vpc-06638c2700e798792" `
 --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=mysec}]"
"GroupId": "sg-0537ad1ae999a7f92" 
#authorized security group port 22
aws ec2 authorize-security-group-ingress `
 --region "us-west-2" `
 --group-id "sg-0537ad1ae999a7f92" `
 --protocol "tcp" `
 --port "22" `
 --cidr "10.10.0.0/16" 
# authorized security group port 80
aws ec2 authorize-security-group-ingress `
 --region "us-west-2" `
 --group-id "sg-0537ad1ae999a7f92" `
 --protocol "tcp" `
 --port "80" `
 --cidr "10.10.0.0/16"
# authorized security group port all
aws ec2 authorize-security-group-ingress `
 --region "us-west-2" `
 --group-id "sg-0537ad1ae999a7f92" `
 --protocol "icmp" `
 --port "all" `
 --cidr "10.10.0.0/16" 
# authorized security group port all
aws ec2 authorize-security-group-ingress `
 --region "us-west-2" `
 --group-id "sg-0537ad1ae999a7f92" `
 --protocol "all" `
 --port "0-65535" `
 --cidr "10.10.0.0/16"
#key pair
aws ec2 create-key-pair `
 --region "us-west-2" `
 --key-name mykeypair1 `
 --query 'KeyMaterial' `
 --output text > mykeypair1.pem

#Ec2  
aws ec2 run-instances `
 --region "us-west-2" `
 --image-id "ami-0d593311db5abb72b" `
 --count 1 `
 --instance-type t2.micro `
 --key-name mykeypair1 `
 --security-group-ids "sg-0537ad1ae999a7f92" `
 --subnet-id "subnet-068223cdd4fc4ef79" `
 --associate-public-ip-address `
 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=web}]"
 
#"InstanceId": "i-0d43f49694da9df73" 

# delete instance
# aws ec2 terminate-instances `
# --instance-ids "i-0d43f49694da9df73"