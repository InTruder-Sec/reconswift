# Get IP addresses

echo "Getting IP Addresses"
host $1 | grep "has address" | cut -d " " -f4 | sort -u | tee -a $basepath/report/ip_addresses.txt


# Get Subdomains

echo "Getting Subdomains"
python3 ./utils/tools/Sublist3r/sublist3r.py -n -d $1 | grep $1 | tee -a $basepath/report/subdomains.txt


# Check for Alive Subdomains
echo "Checking for Alive Subdomains"
./utils/tools/httpx -l $basepath/report/subdomains.txt -silent -threads 100 -timeout 10 -retries 2 -o $basepath/report/alive_subdomains.txt


# # Get Open Ports
# echo "Getting Open Ports"
# cat ./$1/alive_subdomains.txt | naabu -silent -top-ports 1000 -o ./$1/ports.txt

# # Get Technologies
# echo "Getting technologies"
# webtech --urls-file ./$1/alive_subdomains.txt | tee -a ./$1/technologies.txt

# # Get Waybackurls
# # echo "Gathering Waybackurls"
# # ./utils/tools/waybackurl $1 | tee -a ./$1/waybackurls.txt


# # Get Interesting Files
# echo "Gathering Interesting Files"
# gobuster dir -u $1 -w ./wordlists/dir/common.txt -t 100 > ./$1/gobuster.txt
# # dirsearch -u $1 

echo "--------------------------------"
echo "Generating Report"

echo "IP Addresses" >> $basepath/report/report.txt
cat $basepath/report/ip_addresses.txt >> $basepath/report/report.txt
echo "--------------------------------" >> $basepath/report/report.txt

echo "Subdomains" >> $basepath/report/report.txt
cat $basepath/report/subdomains.txt >> $basepath/report/report.txt
echo "--------------------------------" >> $basepath/report/report.txt

echo "Alive Subdomains" >> $basepath/report/report.txt
cat $basepath/report/alive_subdomains.txt >> $basepath/report/report.txt
echo "--------------------------------" >> $basepath/report/report.txt

# echo "Open Ports" >> ./reports/report.txt
# cat ./$1/ports.txt >> ./reports/report.txt
# echo "--------------------------------" >> ./reports/report.txt

# echo "Technologies" >> ./reports/report.txt
# cat ./$1/technologies.txt >> ./reports/report.txt
# echo "--------------------------------" >> ./reports/report.txt

# # echo "Waybackurls" >> ./reports/report.txt
# # cat ./$1/waybackurls.txt >> ./reports/report.txt
# # echo "--------------------------------" >> ./reports/report.txt

# echo "Gobuster" >> ./reports/report.txt
# cat ./$1/gobuster.txt >> ./reports/report.txt
# echo "--------------------------------" >> ./reports/report.txt

# echo "Dirsearch" >> ./reports/report.txt
# cat ../reports/dirsearch.txt >> ./reports/report.txt
# echo "--------------------------------" >> ./reports/report.txt

echo "Report Generated!"
echo "--------------------------------"
echo "Quick Scan Complete!"
echo "--------------------------------"


