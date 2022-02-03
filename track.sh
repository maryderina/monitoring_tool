#!/bin/bash
echo "USER LOGIN DETAILS"
echo ":::::::::::::::::::::::::::::::::::::"
echo "HOST : $(hostname)"
echo "-------------------------------------"
for user in `ls /home`;
do
	count="$(last $user |sed -n 1p | awk '{ print $4 " " $5 " " $6 " " $7 }'| wc -c)"	
	cz=10 
	hrs="$(ac $user | awk '{ print $2 }')"
	echo -ne "***** user: $user";
	latest_login="$(last $user |sed -n 1p | awk '{ print $4 " " $5 " " $6 " " $7 }')";
	if [[ $count -gt $cz  ]]
	then
		echo -ne ": $latest_login *****"
		printf '\n';
	else
		echo " : No Login Record Found *****";
	fi
#	printf '\n'
	echo "total number of hours used: $hrs" 
#	printf '\n';
	lastexec="$(ls -l /home/$user/.bash_history | awk '{ print $7 " " $6 " " $8 }')"
#	export HISTTIMEFORMAT=' %H:%M %d/%m/%y ' ; history | tail | awk '{ $1=""; print }'
	echo "Last command executed on $lastexec"
#	echo "-----------------------------------"
	hist="$(tail -5 /home/$user/.bash_history)"
	echo "$hist"
	printf '\n'
	
done;
