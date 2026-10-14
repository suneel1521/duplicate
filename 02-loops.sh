#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
M="\e[35m"
N="\e[0m"


LOG_FOLDER=/var/log/shell_log
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME"

mkdir -p shell_log

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo -e " $R ERROR: please execute the script with root access $N" | tee -a "$LOG_FILE"
   exit 1
else
   echo -e " $M you are executing scipt with root access $N" | tee -a "$LOG_FILE"
fi

VALIDATE(){

	if [ $1 -eq 0 ]
	then
	   echo -e " $G $2 is installed successful $N" | tee -a "$LOG_FILE"
	else
	   echo -e " $R $2 is installed failure $N" | tee -a "$LOG_FILE"
	fi      
}

PACKAGES=("nginx" "python" "mysql" "httpd")
for package in "${PACKAGES[@]}"
do
  dnf list installed $package &>> "$LOG_FILE"
  if [ $? -eq 0 ]
  then
      echo -e " $M $package is not installed going to install $N" | tee -a "$LOG_FILE"
	  dnf install $package -y &>> "$LOG_FILE"
	  VALIDATE $? "package"
  else
      echo -e " $Y $package is already installed $N" | tee -a "$LOG_FILE"
  fi
done