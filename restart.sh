kill -9 $(lsof -i tcp:3000 -t)
cd /home/developer/work/fss_base
./production.sh 
