#!/bin/bash
cd /home/shubho/Documents/shellclass/exercises
grep "rhost" syslog-sample | awk -F 'rhost=' '{print $2}' | cut -d ' ' -f 1 | sort -n | uniq -c | sort -t ' ' -k1 -n > test

while read line
do
    num= $line | awk '{print $1}'
    if [[ $num > 10 ]]
    then
        echo $line
    fi
done < test