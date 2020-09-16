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
for int_elb in $(cat internal_lbs)
do
  aws elb create-app-cookie-stickiness-policy --load-balancer-name $int_elb --policy-name ${private_policy_name} --cookie-name JSESSIONID
  aws elb set-load-balancer-policies-of-listener --load-balancer-name $int_elb --load-balancer-port 443 --policy-names ${private_policy_name}
done
for ext_elb in $(cat external_lbs)
do
  aws elb create-app-cookie-stickiness-policy --load-balancer-name $ext_elb --policy-name ${public_policy_name} --cookie-name JSESSIONID
  aws elb set-load-balancer-policies-of-listener --load-balancer-name $ext_elb --load-balancer-port 443 --policy-names ${public_policy_name}
done
rm -f internal_lbs
rm -f external_lbs
exit 0