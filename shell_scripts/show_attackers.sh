#!/bin/bash
sample=$(find $HOME -name syslog* | head -n 1)
#sample_dir=$(dirname ${sample})
echo -e "Number of attempts\tIP Address\n\n"
grep "rhost" $sample | awk -F 'rhost=' '{print $2}' | cut -d ' ' -f 1 | sort | uniq -c | sort -nr | while read count ip
do
    if [[ "${count}" -gt 10 ]]
    then
        echo -e "${count}\t\t\t${ip}"
    fi
done
exit 0