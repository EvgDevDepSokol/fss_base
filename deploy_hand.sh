bash -l && {
bundle package
scp -r ~/work/fss_base/vendor/cache/* deploy@10.0.104.151:/home/deploy/handmade/fss_base/vendor/cache/
scp -r ~/work/fss_base/node_modules/* deploy@10.0.104.151:/home/deploy/handmade/fss_base/node_modules/
ENV_RAILS=production bundle exec rake assets:precompile
echo
echo    !!warning!!
echo    connect to server as deploy and run 'bundle update --local'
echo    to update gems
echo
scp -r ~/work/fss_base/public/assets/* deploy@10.0.104.151:/home/deploy/handmade/fss_base/public/assets/

scp -r ~/work/fss_base/* deploy@10.0.104.151:/home/deploy/fss_db_releases/20180810/fss_base/
}
