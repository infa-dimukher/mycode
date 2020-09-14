#!/bin/bash
: > elb_list.txt
env=$1
aws ec2 describe-instances --filter ""Name=tag:Name,Values=MDM-*-${env}*"" --query Reservations[].Instances[].Tags | grep -A1 -B1 Name | grep Value | grep -v -e '-ASG-' | awk -F ':' '{print $2}' | sed 's/"//g' | sed 's/,//g' | sed 's/ //g' | awk -F '-' '{print $2}' | sort -u  | grep -iv bastion > customer_list.txt

for cust in $(cat customer_list.txt)
do
  echo "mdm-${cust}-${env}" >> elb_list.txt
  echo "mdm-int-${cust}-${env}" >> elb_list.txt
done
#rm -f customer_list.txt
exit 0
