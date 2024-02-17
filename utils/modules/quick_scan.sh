host $1 | grep "has address" | cut -d " " -f4 | sort -u | tee -a ./$1/ip_addresses.txt


echo "Getting Subdomains"
sublist3r -n -d $1 | grep $1 | tee -a ./$1/subdomains.txt


echo "Checking for Alive Subdomains"
./tools/httpx -l ./$1/subdomains.txt -silent -threads 100 -timeout 10 -retries 2 -o ./$1/alive_subdomains.txt


echo "Getting Open Ports"
cat ./$1/alive_subdomains.txt | naabu -silent -top-ports 1000 -o ./$1/ports.txt

echo "Getting technologies"
webtech --urls-file ./$1/alive_subdomains.txt | tee -a ./$1/technologies.txt

echo "Gathering Waybackurls"
./tools/waybackurl $1 | tee -a ./$1/waybackurls.txt

echo "Gathering Interesting Files"
#gobuster dir -u $1 -w ./wordlists/dir/common.txt -t 100 -o ./$1/gobuster.txt
dirsearch -u $1
echo "--------------------------------"

