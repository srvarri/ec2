#!/bin/bash
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