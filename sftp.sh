#!/bin/bash
target_dir=/monitoring/cre
[ ! -d "${target_dir}" ] && sudo mkdir -p ${target_dir}
expect << 'EOS'
spawn sftp tsftp@tsftp.informatica.com:/Home/tsftp/vignesh/final_scripts
expect "Password:"
send "infa123\n"
expect "sftp>"
send "lcd /monitoring/cre\n"
expect "sftp>"
send "get -r *\n"
set timeout -1
expect "sftp>"
send "bye\n"
EOS
