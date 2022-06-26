#!/bin/bash
not_sudo=200
if [[ $UID -eq "0" ]]
then
archi=$(uname -i)
which curl > /dev/null || apt install curl
which unzip > /dev/null || apt install unzip
which aws > /dev/null  || {
curl "https://awscli.amazonaws.com/awscli-exe-linux-${archi}.zip" -o "awscliv2.zip"
unzip $PWD/awscliv2.zip
$PWD/aws/install
} && {
        echo "aws-cli 2.7.9is already installed in your machine"
}
else
 exit $not_sudo
fi
