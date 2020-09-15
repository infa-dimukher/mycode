#!/bin/bash

for elb in $(cat elb_list.txt)
do
  aws elb configure-health-check --load-balancer-name $elb --health-check Target=HTTPS:8443/cmx/,Interval=10,UnhealthyThreshold=2,HealthyThreshold=10,Timeout=5
  aws elb modify-load-balancer-attributes --load-balancer-name $elb --load-balancer-attributes "{\"ConnectionSettings\":{\"IdleTimeout\":1800}}"
  aws elb create-app-cookie-stickiness-policy --load-balancer-name $elb --policy-name lb-stickiness-cookie-policy --cookie-name lb-stickiness-cookie
  aws elb set-load-balancer-policies-of-listener --load-balancer-name $elb --load-balancer-port 443 --policy-names lb-stickiness-cookie-policy
  aws elb delete-load-balancer-listeners --load-balancer-name $elb --load-balancer-ports 80
done
