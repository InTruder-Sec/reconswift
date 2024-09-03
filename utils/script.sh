#!/bin/bash

# $1 domain
# $2 scan intensity

echo "-----------------------------------------------------------------------------"
echo "Welcome to ReconSwift!"
echo "A simple bash script to automate the recon process"
echo Date: `date`
echo Author: @InTrud3r
echo "-----------------------------------------------------------------------------"


export basepath=$(pwd)/.temp/
echo $basepath
rm -rf $basepath/report || echo "Clead directory"
mkdir $basepath
# save all files to $basepath

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

# Clean $1 domain remove last / if present
if [[ $1 == */ ]]
then
	export domain=$(echo $1 | sed 's/.$//')
else
	export domain=$1
fi

echo "-----------------------------------------------------------------------------"

echo "Running ReconSwift Modules!"
echo "Creating files for $1"
mkdir .temp/report
touch $basepath/report/report.txt


echo "-----------------------------------------------------------------------------" >> ./reports/report.txt
echo "ReconSwift Report" >> $basepath/report/report.txt
echo "Date: `date`" >> $basepath/report/report.txt
echo "Author: @InTrud3r" >> $basepath/report/report.txt
echo "-----------------------------------------------------------------------------" >> ./reports/report.txt


if [ $2 = "Quick" ];
then
	
	echo "Running Quick Scan!"
	#bash $basepath/../utils/modules/quick_scan.sh $domain
	./utils/modules/quick_scan.sh $domain || echo "Something went wron 2"

elif [ $2 = "Full" ];
then

	echo "Running Full Scan!"
	bash $basepath/../utils/modules/full_scan.sh $domain

elif [ $2 = "Advanced" ];
then
	
	echo "Running Advanced Scan!"
	bash $basepath/../utils/modules/advanced_scan.sh $domain

else
	echo "Invalid Scan Intensity"
	exit 1
fi


echo "-----------------------------------------------------------------------------" >> $basepath/report/report.txt
echo "-----------------------------------------------------------------------------" >> $basepath/report/report.txt

echo "Report for $1 has been created!"
echo "ReconSwift has finished running!"
echo "Thank you for using ReconSwift!"
echo "-----------------------------------------------------------------------------"


curl -X GET -H "Content-Type: application/json" http://localhost:80/api/v1/completescan?Id=$4
