#!/bin/bash

# $1 domain
# $2 scan intensity

echo "--------------------------------"
echo "Welcome to ReconSwift!"
echo "A simple bash script to automate the recon process"
echo "--------------------------------"


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

echo Target Domain: $1
echo Scan Intensity: $2

echo "--------------------------------"
echo "Running ReconSwift Modules!"
echo "Creating files for $1"
mkdir $1

if [ $2 = "qs" ];
then
	
	echo "Running Quick Scan!"
	./modules/quick_scan.sh $1 

elif [ $2 = "fs" ];
then

	echo "Running Full Scan!"
	./modules/full_scan.sh $1

elif [ $2 = "as" ];
then
	
	echo "Running Advanced Scan!"
	./modules/advanced_scan.sh $1

else
	echo "Invalid Scan Intensity"
	exit 1
fi

echo "--------------------------------"
echo "Creating Report for $1"

touch $1/report.txt

echo "--------------------------------" >> $1/report.txt
echo "ReconSwift Report" >> $1/report.txt
echo date >> $1/report.txt
echo "Target Domain: $1" >> $1/report.txt
echo "Scan Intensity: $2" >> $1/report.txt
echo "--------------------------------" >> $1/report.txt
echo "Combining files"
echo "--------------------------------" >> $1/report.txt

cat $1/ip_addresses.txt >> $1/report.txt
echo "--------------------------------" >> $1/report.txt
cat $1/subdomains.txt >> $1/report.txt
echo "--------------------------------" >> $1/report.txt
cat $1/alive_subdomains.txt >> $1/report.txt
echo "--------------------------------" >> $1/report.txt
cat $1/ports.txt >> $1/report.txt
echo "--------------------------------" >> $1/report.txt
cat $1/technologies.txt >> $1/report.txt
echo "--------------------------------" >> $1/report.txt
cat $1/robots.txt >> $1/report.txt
echo "--------------------------------" >> $1/report.txt
cat $1/waybackurls.txt >> $1/report.txt
echo "--------------------------------" >> $1/report.txt
cat $1/interesting_files.txt >> $1/report.txt
echo "--------------------------------" >> $1/report.txt
cat $1/interesting_directories.txt >> $1/report.txt
echo "--------------------------------" >> $1/report.txt



echo "--------------------------------"
echo "ReconSwift has finished running!"


