# Get Ip Addresses

host $1 | grep "has address" | cut -d " " -f4 | sort -u | tee -a ./$1/ip_addresses.txt


# The bellow code is giving no such file or directory error

sublist3r -d $1 | grep $1 | tee -a ./$1/subdomains.txt

# Check for Alive Subdomains
echo "Checking for Alive Subdomains"

cat ./$1/subdomains.txt | httprobe | tee -a ./$1/subdomains.txt   



