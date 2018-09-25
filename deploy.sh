./stop.sh
# ./clean_ass
ssh deploy@10.0.104.151 "cd fss_db_releases && mkdir '$(date +%Y%m%d)'" 
ssh deploy@10.0.104.151 "cd fss_db_releases && cd '$(date +%Y%m%d)' && mkdir fss_base" 
scp -r ~/work/fss_base/* deploy@10.0.104.151:/home/deploy/fss_db_releases/$(date +%Y%m%d)/fss_base/
ssh deploy@10.0.104.151 "cd fss_db_releases && cd '$(date +%Y%m%d)' && cd fss_base && ./stop.sh && bundle update --local && ./production.sh"
