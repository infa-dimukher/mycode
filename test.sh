#!/bin/bash
user_name=$(id -un)
echo "Your User ID is " ${UID}
echo "Your username is:  ${user_name}"
if [[ "$UID" -eq 0 ]]
then
    echo "You are root user"
else
    echo "You are NOT a root user"
fi
#test -f /home/shubho/Documents/test.sh && echo "Its a file and not a directory"
echo "${#}"
exit 0