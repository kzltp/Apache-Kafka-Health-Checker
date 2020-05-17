#!/bin/bash
###################################################################
#Script Name	: apachekhc.sh                                                                                             
#Description    :
#Requirement	:                                                                                 
#Args           :                                                                                           
#Author       	:Arif KIZILTEPE                                                
#Email         	:kzltpsgm@gmail.com                                          
###################################################################

#Read Conf...
source /home/apachekhc.conf


#Coler variables
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


proc(){
printf "${RED}1${NC}      Broker List Detail\n"
printf "${RED}2${NC}      Topic List Detail\n"
printf "${RED}0${NC}      Exit\n"
read -p "Choose action :" pn
}

ynques(){
while true;
do
	read -p "Do you want to continue (Y/N) :" yn
	if [[ "$yn" = "Y"  ||  "$yn" = "y" ]]
	then
		proc
		break
	elif [[ "$yn" = "N"  ||  "$yn" = "n" ]]
	then
		exit
	else
		echo "Incorrect choice. Try again."
		read -p "Do you want to continue (Y/N) :" yn
	fi
done

}

# display back 3 numbers - punched by user. 

proc


while true; 
do 
	#Exit
	if [ "$pn" = "0" ]
	then
		exit
	#Broker List Detail
	elif [ "$pn" = "1" ]
	then
		BLIST=$(${KHOME}/bin/zookeeper-shell.sh ${ZHOST}:${ZPORT} ls /brokers/ids | tail -1 | sed $'s/[[:punct:]\t]//g')
		for i in $BLIST
		do
			echo "Broker ID = ${i}"
			${KHOME}/bin/zookeeper-shell.sh ${ZHOST}:${ZPORT}  get /brokers/ids/${i} | grep host
			printf "\n"
		done
		printf "\n \n \n"
		ynques
	elif [ "$pn" = "2" ]
	then
		${KHOME}/bin/zookeeper-shell.sh ${ZHOST}:${ZPORT} ls /brokers/topics| awk 'END{print}'
		printf "\n \n \n"
		ynques
	else
		echo "Incorrect choice. Try again."
		ynques
	fi
done
