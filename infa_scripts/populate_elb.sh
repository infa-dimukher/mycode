#!/bin/bash
: > elb_list.txt
aws_region="us-east-1 us-west-2 ca-central-1 eu-west-1"
for region in $aws_region
do
  echo "# ${region} MDM Load balancers" >> elb_list.txt
  echo -e "-------------------\n" >> elb_list.txt
  aws elb describe-load-balancers | grep LoadBalancerName | awk '{print $2}' | grep mdm- | sed 's/,//' | sed 's/"//g' >> elb_list.txt
done
exit 0
