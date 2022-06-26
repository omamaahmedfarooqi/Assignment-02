#!/bin/bash
ROOT_UID=0
E_NOTROOT=100

read -rp "Install or Upgrade Ngnix? (y/n)" INSTALL

if [[ $INSTALL =~ ^([yY][eE][sS]|[yY])$ ]]; then

     if [ "$UID" -ne "$ROOT_UID" ]
     then
          echo "Must be root to run this script."
          exit $E_NOTROOT

     fi

          which nginx &> /dev/null || {
                echo "Installing Nginx"
                apt install update -y
                apt install upgrade -y
                apt install nginx

          echo;
          echo "Nginx is installed successfully!"

          } && {
            echo "Updating Nginx"
            apt install update -y
            apt install upgrade -y
            apt install nginx --upgrade
          }


          echo "Updated and Upgraded successfully!"

fi
