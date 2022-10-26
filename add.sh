########################################################
  ### Creating a security group for the public instances
PubSecGrpID=$(aws ec2 create-security-group --group-name PubSecGrp \
            --description "Security Group for public instances" \
            --vpc-id "$PubVPC_ID" \
            --output text)
			
### Creating a security group for the private instances
PvtSecGrpID=$(aws ec2 create-security-group --group-name PvtSecGrp \
            --description "Security Group for private instances" \
            --vpc-id "$PvtVPC_ID" \
            --output text)


#### Add a rule that allows inbound SSH, HTTP, HTTP traffic ( from any source )
aws ec2 authorize-security-group-ingress --group-id "$PubSecGrpID" --protocol tcp --port 22 --cidr 0.0.0.0/0


### Create two EC2 Instances

##### Public Instances

pubInstanceID=$(aws ec2 run-instances \
           --image-id ami-2051294a \
           --count 1 \
           --instance-type t2.micro \
           --key-name kum-key \
           --security-group-ids "$pubSecGrpID" \
           --subnet-id "$pubVPC_Subnet01ID" \
           --associate-public-ip-address \
           --query 'Instances[0].InstanceId' \
           --output text)
 ##### Tag the instanes
aws ec2 create-tags --resources "$pubInstanceID" --tags 'Key=Name,Value=Public-Instance'               