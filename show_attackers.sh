#!/bin/bash
cd /home/shubho/Documents/shellclass/exercises
grep "rhost" syslog-sample | awk -F 'rhost=' '{print $2}' | cut -d ' ' -f 1 | sort -n | uniq -c | sort -t ' ' -k1 -n > test

while IFS= read -r line
do
    index= `echo $line | awk '{print $1}'`
    #if [[ "${index}" > 10 ]]
    #then
        echo $line
        echo $index
    #fi
done < test