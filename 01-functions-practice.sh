#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
M="\e[35m"
N="\e[0m"

VALIDATE(){

   if [ $1 -eq 0 ]
   then
      echo -e " $G installing $2 .....success $N "
   else
      echo -e " $R installing $2 .....failure $N "
      exit 1
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

dnf list installed python
if [ $? -eq 0 ]
then
   echo -e " $M python is not installed.....going to install $N "
   dnf install python -y
   VALIDATE $? "python"
else
   echo " $Y pythone is already installed $N "
fi