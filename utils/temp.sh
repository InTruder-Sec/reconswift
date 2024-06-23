echo "Testing"

pwd



echo "Checking tools"

cd ./utils/tools/ 
ls -la
file httpx
chmod +x httpx
httpxx --version
./httpx --version || echo "error"

python3 ./utils/tools/Sublist3r/sublist3r.py -h