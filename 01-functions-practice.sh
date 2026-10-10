#!/bin/bash

USERID=$(id -u)

R="e\[31m"
G="e\[31m"
Y="e\[31m"
B="e\[31m"
M="e\[31m"
N="e\[0m"

VALIDATE(){

   if [ $1 -eq 0 ]
   then
      echo -e " $G installing nginx.....success $N "
   else
      echo -e " $R installing nginx.....failure $N "
   fi   
}

if [ $USERID -ne 0 ]
then
   echo -e " $R please run the script with root access $N "
   exit 1
else
   echo -e " $B you are running with root access $N "
fi

dnf list installed nginx
if [ $? -eq 0 ]
then
   echo -e " $M nginx is not installed....going to install $N "
   dnf install nginx -y
   VALIDATE $? "nginx"
else
   echo -e " $Y nginx is already installed $N "
fi