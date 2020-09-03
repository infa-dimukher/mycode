#!/bin/bash
base_string=$(date +%s%N${RANDOM} | sha256sum | head -c8)
spcl_char=$(echo '!@#$%^&*()_+\' | fold -w1 | shuf -n1)
final_string=${base_string}${spcl_char}
echo ${final_string}