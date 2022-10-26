#!/bin/bash
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