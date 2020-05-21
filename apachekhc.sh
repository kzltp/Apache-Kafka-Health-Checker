#!/bin/bash
echo -e "\033[0;32m###################################################################"
echo "#Script Name	    : apachekhc.sh												"                                                                                                                               
echo "#Description      : 		"                                         
echo "#Requirement	    :   "                                                                                                                              
echo "#Args             :   "                                                                                                                                     
echo "#Author       	: Arif KIZILTEPE  "                                                                            
echo "#Email         	: kzltpsgm@gmail.com   "                                                                 
echo -e "###################################################################"

#Read Conf...
source apachekhc.conf


#Coler variables
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


proc(){
printf "  ${RED}(1)${NC}      Broker List Detail\n"
printf "  ${RED}(2)${NC}      Topic List\n"
printf "  ${RED}(3)${NC}      Topic Detail\n"
printf "  ${RED}(4)${NC}      Consumer Group List\n"
printf "  ${RED}(5)${NC}      Consumer Group Detail\n"
printf "  ${RED}(6)${NC}      Message Detail\n"
printf "  ${RED}(0)${NC}      Exit\n"
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
		read -p "Do you want to continue (Y/N) : " yn
	fi
done

}


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
		BLIST=$(${KHOME}/bin/zookeeper-shell.sh ${HOST}:${ZPORT} ls /brokers/ids | tail -1 | sed $'s/[[:punct:]\t]//g')
		for i in $BLIST
		do
			echo "Broker ID = ${i}"
			${KHOME}/bin/zookeeper-shell.sh ${HOST}:${ZPORT}  get /brokers/ids/${i} | grep host
			printf "\n"
		done
		printf "\n \n \n"
		ynques
	#Topic List 
	elif [ "$pn" = "2" ]
	then
		${KHOME}/bin/zookeeper-shell.sh ${HOST}:${ZPORT} ls /brokers/topics| awk 'END{print}'
		printf "\n \n \n"
		ynques
	#Topic List Detail
	elif [ "$pn" = "3" ]
	then
		TLIST=$(${KHOME}/bin/zookeeper-shell.sh ${HOST}:${ZPORT} ls /brokers/topics| awk 'END{print}'| sed $'s/[[:punct:]\t]//g' | sed "s/consumeroffsets//")
		for i in $TLIST
		do
			echo "Topic Name = ${i}"
			${KHOME}/bin/kafka-topics.sh --describe --topic ${i} --zookeeper ${HOST}:${ZPORT}
			printf "\n"
		done
		printf "\n \n \n"
		ynques
	#Consumer Group List
	elif [ "$pn" = "4" ]
	then
		CLIST=$(${KHOME}/bin/kafka-consumer-groups.sh --list --bootstrap-server ${HOST}:${KPORT} )
		echo $CLIST
		ynques
	#Consumer Group Detail
	elif [ "$pn" = "5" ]
	then
		CLIST=$(${KHOME}/bin/kafka-consumer-groups.sh --list --bootstrap-server ${HOST}:${KPORT})
		for i in $CLIST
		do
			echo "Consumer Group = ${i}"
			${KHOME}/bin/kafka-consumer-groups.sh --describe --group ${i} --bootstrap-server ${HOST}:${KPORT}
			printf "\n"
		done
		printf "\n \n \n"
		ynques
	#Message Detail
	elif [ "$pn" = "6" ]
	then
		CLIST=$(${KHOME}/bin/kafka-consumer-groups.sh --list --bootstrap-server ${HOST}:${KPORT})
		for i in $CLIST
		do
			echo "Consumer Group = ${i}"
			ALLMESS=$(${KHOME}/bin/kafka-consumer-groups.sh --describe --group ${i} --bootstrap-server ${HOST}:${KPORT} | awk  '{sum += $5} END {print sum}' | grep -v " has no active members")
			READEDMESS=$(${KHOME}/bin/kafka-consumer-groups.sh --describe --group ${i} --bootstrap-server ${HOST}:${KPORT} | awk  '{sum += $4} END {print sum}')
			UNREADMESS=$(${KHOME}/bin/kafka-consumer-groups.sh --describe --group ${i} --bootstrap-server ${HOST}:${KPORT} | awk  '{sum += $6} END {print sum}')
			
			echo "All Messages : ${ALLMESS}"
			echo "Read Messages : ${READEDMESS}"
			echo "Unread Messages : ${UNREADMESS}"
			printf "\n"
		done
		printf "\n \n \n"
		ynques
	
	else
		echo "Incorrect choice. Try again."
		ynques
	fi
done
