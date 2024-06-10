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

rm -rf $basepath/report

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


if [ $2 = "Quick_Scan" ];
then
	
	echo "Running Quick Scan!"
    $basepath/utils/modules/quick_scan.sh $1

elif [ $2 = "Full_Scan" ];
then

	echo "Running Full Scan!"
	$basepath/utils/modules/full_scan.sh

elif [ $2 = "Advanced_Scan" ];
then
	
	echo "Running Advanced Scan!"
	$basepath/utils/modules/advanced_scan.sh

else
	echo "Invalid Scan Intensity"
	exit 1
fi


echo "-----------------------------------------------------------------------------" >> $basepath/report/report.txt
echo "-----------------------------------------------------------------------------" >> $basepath/report/report.txt

rm -rf $basepath/report/
echo "Report for $1 has been created!"
echo "ReconSwift has finished running!"
echo "Thank you for using ReconSwift!"
echo "-----------------------------------------------------------------------------"


curl -X GET -H "Content-Type: application/json" http://localhost:5000/api/v1/completescan?Id=$3