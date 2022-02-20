#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`

result=0
downtime=0

if [ $# -eq 0 ]; then
 echo "Running health checks on $1"
 exit 1
else
 while true
 do
  result=`curl --max-time 5 -s $1 > /dev/null`
  result=$?
  if [ $result -eq 0 ]; then
   echo “${green}Website is up and running!!”
   sleep 5
  else
   echo “${red}The website is unreachable!!”
   sleep 5
   downtime=$[$downtime+1]
   if [ $downtime -eq 5 ]; then
      echo -e "\nThere seems to be some technical issue with website, exiting the healthcheck process now. Please fix!"
      exit 1
   fi
  fi
 sleep 1
 done
fi