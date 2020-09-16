#!/bin/bash
private_policy_name="private-stickinesspolicy-1"
public_policy_name="public-stickinesspolicy-1"
cat elb_list.txt | grep int > internal_lbs
cat elb_list.txt | grep -v int > external_lbs
for elb in $(cat elb_list.txt)
do
  aws elb configure-health-check --load-balancer-name $elb --health-check Target=TCP:8443,Interval=30,UnhealthyThreshold=2,HealthyThreshold=10,Timeout=5
  aws elb modify-load-balancer-attributes --load-balancer-name $elb --load-balancer-attributes "{\"ConnectionSettings\":{\"IdleTimeout\":1800}}"
  aws elb create-load-balancer-listeners --load-balancer-name $elb --listeners "Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80"
done
rm -f internal_lbs
rm -f external_lbs
exit 0