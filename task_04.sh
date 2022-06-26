#!/bin/bash

archi=$(uname -i)
if [[ "$UID" -ne 0 ]]
then
    echo "Sudo access required"

else
    which aws > /dev/null || {
    curl "https://awscli.amazonaws.com/awscli-exe-linux-${archi}.zip" -o "awscliv2.zip"
    unzip $PWD/awscliv2.zip
    $PWD/aws/install
    } && {
      AWS_ACCESS_KEY_ID=$(aws --region=us-east-1 ssm get-parameter --name "MY_ACCESS_KEY" --with-decryption --output text --query Parameter.Value)
      echo ${AWS_ACCESS_KEY_ID}

      AWS_SECRET_ACCESS_KEY=$(aws --region=us-east-1 ssm get-parameter --name "MY_SECRET_KEY" --with-decryption --output text --query Parameter.Value)
      echo ${AWS_SECRET_ACCESS_KEY}
    }
    fi
