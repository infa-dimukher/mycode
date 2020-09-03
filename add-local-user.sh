#!/bin/bash
if [[ ${UID} -ne 0 ]]
then
    echo "Only root user can add new logins" >&2
    exit 1
elif [[ "${#}" -lt 3 ]]
then
    echo -e "Exiting as all the required argument(s) are missing\nUSAGE: ${0} <username> <FIRST NAME> <LAST NAME>" >&2
    exit 1
else
    user_name=$1
    shift
    comment="$*"
fi
public_ip=$(curl -s ifconfig.me)
pass=$(/home/shubho/Documents/create_password.sh)
#read -p "Enter user name: " user_name
for _usr in $(awk -F':' '{print $1}' /etc/passwd)
do
  if [[ ${_usr} == "${user_name}" ]]
  then
      echo "The user already exists in Library"
      echo -e "Do you want to recreate? (Y/n)\nWARNING: Doing yes will delete the home directory"
      read -p "Your input: " input
      if [[ $input == "Y" ]]
      then
        deluser --remove-home ${user_name}
      else
        exit 0
      fi  
  fi
done
#read -p "Enter full name: " comment
#echo "Enter password for the user: "
#read -s pass
useradd --comment "${comment}" --create-home $user_name
echo "${user_name}:${pass}" | chpasswd
passwd --expire $user_name
if [[ "${?}" -eq 0 ]]
then
    echo -e "User created successfully. Please log in to change your password\n"
    touch ./new_user.txt
    echo -e "Username: ${user_name}\nTemporary Password: "${pass}"\nFull Name: "${comment}"\nHost Name: `hostname`\nIP Address: `hostname -I`\nPublic IP: ${public_ip}" > new_user.txt
    chown shubho:shubho new_user.txt
    chmod 440 new_user.txt
    exit 0
else
    echo -e "User creation unsuccessful\n" >&2
    exit 1
fi
