myip=$(dig @resolver4.opendns.com myip.opendns.com +short)
myaddress=$(dig -x $myip +short) 
myisp=$(echo $myaddress | awk -F. '{print $(NF-2)}')
echo "$myisp"
