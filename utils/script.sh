#!/bin/bash

# $1 domain
# $2 scan intensity

echo "-----------------------------------------------------------------------------"
echo "Welcome to ReconSwift!"
echo "A simple bash script to automate the recon process"
echo Date: `date`
echo Author: @InTrud3r
echo "-----------------------------------------------------------------------------"


if [ -z "$1" ]
then
	  echo "No domain supplied"
	  exit 1
fi

if [ -z "$2" ]
then
	  echo "No scan intensity supplied"
	  exit 1
fi

if [ -z "$3" ]
then
	  echo "No scan id supplied"
	  exit 1
fi

echo Target Domain: $1
echo Scan Intensity: $2

echo "-----------------------------------------------------------------------------"

echo "Running ReconSwift Modules!"
echo "Creating files for $1"
mkdir $1

if [ $2 = "Quick_Scan" ];
then
	
	echo "Running Quick Scan!"
	./utils/modules/quick_scan.sh $1

elif [ $2 = "Full_Scan" ];
then

	echo "Running Full Scan!"
	./modules/full_scan.sh $1 

elif [ $2 = "Advanced_Scan" ];
then
	
	echo "Running Advanced Scan!"
	./modules/advanced_scan.sh $1 

else
	echo "Invalid Scan Intensity"
	exit 1
fi

echo "-----------------------------------------------------------------------------"
echo "Creating Report for $1"

touch ./reports/report.txt

echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
echo "ReconSwift Report" >> ./reports/report.txt
echo "Date: `date`" >> ./reports/report.txt
echo "Author: @InTrud3r" >> ./reports/report.txt
echo "-----------------------------------------------------------------------------" >> ./reports/report.txt

echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
echo "IP Addresses" >> ./reports/report.txt
echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
cat $1/ip_addresses.txt >> ./reports/report.txt

echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
echo "Subdomains" >> ./reports/report.txt
echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
cat $1/subdomains.txt >> ./reports/report.txt

# echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
# echo "Alive Subdomains" >> ./reports/report.txt
# echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
# cat $1/alive_subdomains.txt >> ./reports/report.txt

# echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
# echo "Open Ports" >> ./reports/report.txt
# echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
# cat $1/ports.txt >> ./reports/report.txt

# echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
# echo "Technologies" >> ./reports/report.txt
# echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
# cat $1/technologies.txt >> ./reports/report.txt

# echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
# echo "Waybackurls" >> ./reports/report.txt
# echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
# cat $1/waybackurls.txt >> ./reports/report.txt

# echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
# echo "Interesting Files" >> ./reports/report.txt
# echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
# cat $1/gobuster.txt >> ./reports/report.txt

echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
echo "-----------------------------------------------------------------------------" >> ./reports/report.txt

rm -rf $1
rm -rf reports/_$1
echo "Report for $1 has been created!"
echo "ReconSwift has finished running!"
echo "Thank you for using ReconSwift!"
echo "-----------------------------------------------------------------------------"


curl -X GET -H "Content-Type: application/json" http://localhost:5000/api/v1/completescan?Id=$3