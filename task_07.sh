#!/bin/bash

ROOT_UID=0
NOT_ROOT=200

AWS_ACCESS_KEY_ID=$(aws --region=us-east-1 ssm get-parameter --name "MY_ACCESS_KEY" --with-decryption --output text --query Parameter.Value)
AWS_SECRET_ACCESS_KEY=$(aws --region=us-east-1 ssm get-parameter --name "MY_SECRET_KEY" --with-decryption --output text --query Parameter.Value)
AWS_DEFAULT_REGION=us-east-1

AMI="ami-08d4ac5b634553e16"
COUNT=1
INSTANCE_TYPE="t2.micro"
KEY_NAME="asssignment-02-kp"
SUBNET_ID="subnet-0517539f7439faa04"
TAG='ResourceType=instance,Tags=[{Key=Name,Value=website-server}]'
SG="sg-0f100a996784d6174"

if [ "$UID" -ne "$ROOT_UID" ]
    then
        echo "Must be root to run this script."
        exit $NOT_ROOT
fi

source task_04.sh

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_DEFAULT_REGION



echo "Launching EC2...."
aws ec2 run-instances \
        --image-id $AMI \
        --count $COUNT \
        --instance-type $INSTANCE_TYPE \
        --key-name $KEY_NAME \
        --security-group-ids $SG \
        --subnet-id $SUBNET_ID \
        --tag-specifications $TAG \
        --user-data "$(cat userdata.txt)"

