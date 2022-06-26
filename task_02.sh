#!/bin/bash
not_sudo=200
error=404
green='\033[0;32m'
white='\033[0m'
red='\033[0;31m'
if [[ $UID -eq "0" ]]
then
which nginx > /dev/null ||{
 echo -e "${red}Something went wrong, NGINX cannot be activated ${white}"
 exit $error
} && {
status=$(systemctl status nginx | grep Active | awk '{print $2}')
if [[ $status = "inactive" ]]
then
        echo -e  "${red}NGINX is Dead. Do you want to run NGINX [y/n]? ${white}"
read input

if [[ $input = "y" ]]
then
        systemctl start nginx
else
        echo -e "${red}Something went wrong, NGINX cannot be activated ${white}"
fi
else
        echo -e "${green}server is running ${white}"
fi
}
else
        echo "Sudo access required"
 fi
