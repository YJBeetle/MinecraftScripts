#!/bin/bash
java="java -Xmx2G"
args="nogui"
restart=true

update=true
export folder=server
export infofile=$folder/latest.txt

while :; do
	[ "$update" == "true" ] && ./update_server.sh
	[ -e "$infofile" ] && file="$(<$infofile)"
	[ -z "$file" ] && echo -e "\e[1;31mCannot locate executable file from $infofile\e[0m" && read -s && exit 1

	echo -e "\e[1;33mStarting $folder/$file...\e[0m"
	(cd $folder; $java -jar "$file" $args)
	[ "$restart" != "true" ] && break
	sleep 5
done
exit 0