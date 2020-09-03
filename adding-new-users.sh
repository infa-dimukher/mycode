#!/bin/bash
usage() {
    echo "USAGE: ${0} [-u] <username> [-f] <full name>"
    echo "OPTIONAL ARGUMENTS: [-v] verbose [-l] password length"
    exit 1
}
put() {
    message="${@}"
    if [[ ${verbose} == "true" ]]
    then
        echo "${message}"
    fi
}
mandatory_arg_check() {
    if [[ -z "${user_name}" ]] || [[ -z "${full_name}" ]]
    then
        echo "Null argument passed" >&2
        usage
    elif [[ "${full_name}" =~ [0-9] ]] || [[ "${full_name}" =~ ['!@#$%^&*()_+'] ]]
    then
        echo "Full name must not contain any number or special character" >&2
        usage
    fi
}
usr_validation() {
    if [[ ${UID} -ne 0 ]]
    then
        echo "Only root user can add new logins" >&2
        exit 1
    fi
}
generate_pass() {
    local base_string=$(date +%s%N${RANDOM} | sha256sum | head -c$length)
    local spcl_char=$(echo '!@#$%^&*()_+\' | fold -w1 | shuf -n1)
    local final_string=${base_string}${spcl_char}
    echo $final_string
}
create_user() {
    put "Deleting old info file..."
    rm -f new_user.txt
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
    put "Creating user..."
    local public_ip=$(curl -s ifconfig.me)
    useradd --comment "${full_name}" --create-home $user_name
    put "Generating random password..."
    pass=$(generate_pass)
    echo "${user_name}:${pass}" | chpasswd
    passwd --expire $user_name
    if [[ "${?}" -eq 0 ]]
    then
        touch ./new_user.txt
        echo -e "Username: ${user_name}\nTemporary Password: "${pass}"\nFull Name: "${comment}"\nHost Name: `hostname`\nIP Address: `hostname -I`\nPublic IP: ${public_ip}" > new_user.txt
        put "Setting permission to output file..."
        chown shubho:shubho new_user.txt
        chmod 440 new_user.txt
        echo -e "User created successfully. Please log in to change your password\n"
        exit 0
    else
        echo -e "User creation unsuccessful\n" >&2
        exit 1
    fi
}
usr_validation
length=20
while getopts u:f:l:v option
do
    case $option in
        u)
            user_name="${OPTARG}"
            ;;
        f)
            full_name="${OPTARG}"
            if [[ -z "${full_name}" ]]
            then
                echo "Null argument passed"
                usage
            fi
            ;;
        v)
            verbose="true"
            echo "verbose mode on..."
            ;;
        l)
            length="${OPTARG}"
            ;;
        *)
            echo "Invalid argument" >&2
            usage
            ;;
    esac
done
shift "$(( OPTIND-1 ))"
if [[ "${#}" -gt 0 ]]
then
    usage
fi
mandatory_arg_check
create_user