#!/bin/bash

#####################
# Author : Suyash Das
# Date : 26th May, 2026
# Version : v1
# This version will report the AWS Resource usage
#####################


set -x

#list s3 buckets
echo "List of s3 buckets"
aws s3 ls

#list of EC2 instances
echo "List of ec2 instances"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

#list of lambda
aws lambda list-functions

#list IAM Users
aws iam list-users


