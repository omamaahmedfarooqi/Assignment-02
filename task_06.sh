#!/bin/bash

ROOT_UID=0
NOT_ROOT=200

if [[ "$UID" -ne "$ROOT_UID" ]]
 then
     echo "Sudo access required"
     exit $NOT_ROOT
fi

source task_01.sh
source task_02.sh

which curl > /dev/null || apt-get install curl && {
   rm -f index.html > /dev/null
   curl -L -o index.html "https://drive.google.com/uc?export=download&id=1_SBGZE67Ullw3Xq6B9OPnIcAXBVrBsPM" &> /dev/null
   rm -rf /var/www/html/*

   systemctl status nginx > /dev/null

   nginx_status_output=$?

   if [[ "$nginx_status_output" == "$nginx_running_status" ]]
     then
          nginx_status='Dead'
     else
          nginx_status='Active'
     fi

   student_name="Omama"
   nginx_version=$(nginx -v 2>&1 | awk -F' ' '{print $3}' | cut -d / -f 2)
   aws_cli=$(aws --version | awk '{print $1}' | tr '/' ' ' | awk '{print $2}')
   instance_count=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId]' --output text | wc -l)
   sec_count=$(aws ec2 describe-security-groups --query "SecurityGroups[*].{Name:GroupName}"  --output text | wc -l)

   sed -i "s/STUDENTNAME/$student_name/g" $PWD/index.html
   sed -i "s/NGINXSTATUS/$nginx_status/g" $PWD/index.html
   sed -i "s/NGINXVERSION/$nginx_version/g" $PWD/index.html
   sed -i "s/VERSIONAWS/$aws_cli/g" $PWD/index.html
   sed -i "s/EC2COUNT/$instance_count/g" $PWD/index.html
   sed -i "s/SECGRPCOUNT/$sec_count/g" $PWD/index.html

   echo "successfully updated"
   mv $PWD/index.html /var/www/html
}
