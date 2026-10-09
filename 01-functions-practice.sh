#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo "ERROR: please run the script with root access"
exit 1
else
   echo "you are running with root access"
fi

VALIDATE(){

    if [ $1 -eq 0 ]
    then
       echo "installing $2 is.....success"
    else
       echo "installing $2 is....failure"
       exit 1
    fi
}

dnf list installed mysql

if [ $? -ne 0 ]
then
   echo "mysql is not installed....going to be installed"
   dnf install nginx -y
   VALIDATE $? "mysql"
else
   echo "mysql is already installed....nothing to do change"
fi