#!/usr/bin/env bash
touch ip.txt
netstat -ntup | awk ' $5 ~ /^[0-9]/ {print $5,$7}' | cut -d: -f1,2 | sort | uniq -c | sort -n |tr ':' '\ '|awk '{print $2,$4}' > ip.txt
#netstat -ntu | awk ' $5 ~ /^[0-9]/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort -n |awk '{print $2}' > ip.txt
#urls=$(netstat -ntu | awk ' $5 ~ /^[0-9]/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort -n |awk '{print $2}')
while read line
do
        #netw=$(whois "$line" |grep -i 'owner:\|netname:')
        linea=$(echo $line|awk '{print $1}')
        proceso=$(echo $line|awk '{print $2}')
        #netw=$(whois -h v4.whois.cymru.com -v "$linea" | sed -n 3p | awk '{ s = ""; for (i = 13; i <= NF; i++) s = s $i " "; print s }')
        lugar=$(geoiplookup "$linea" | grep Country | awk '{print $5" "$6}')
        #echo "$lugar"'|'"$linea"'|'"$netw"'|'"$proceso"
        echo "$lugar"'|'"$linea"'|'"$proceso"
done < "ip.txt"
rm ip.txt

#end
