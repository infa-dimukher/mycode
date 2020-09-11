#!/bin/bash
: > inventory.txt
region=$1
_ENV="qa prod"
for env in $_ENV
do
    for customer in $(cat customer_list.txt)
    do
        if [[ $env == "qa" ]]
        then
            qa="APP-1 VIBE-1 SS-1"
            for type in $qa
            do
                ip=$(aws ec2 describe-instances --filters Name=tag-value,Values=MDM-${customer}-${env}-${type} --output text | grep PRIVATEIPADDRESSES | awk '{print $3}')
                echo "MDM-${customer}-${env}-${type} ansible_ssh_host=$ip ansible_ssh_private_key_file=/provisioning-data/customers/${customer}/${region}/${env}/operations_key/${customer}_${env}_operations_key.pem ansible_ssh_user=ec2-user" >> inventory.txt
            done
        else
            prod="APP-1 APP-2 VIBE-1 VIBE-2 SS-1 SS-2"
            for type in $prod
            do
                ip=$(aws ec2 describe-instances --filters Name=tag-value,Values=MDM-${customer}-${env}-${type} --output text | grep PRIVATEIPADDRESSES | awk '{print $3}')
                echo "MDM-${customer}-${env}-${type} ansible_ssh_host=$ip ansible_ssh_private_key_file=/provisioning-data/customers/${customer}/${region}/${env}/operations_key/${customer}_${env}_operations_key.pem ansible_ssh_user=ec2-user" >> inventory.txt
            done
        fi
    done
done
exit 0