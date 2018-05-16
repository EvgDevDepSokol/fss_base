bash -l && {
bundle package
scp -r ~/work/fss_base/vendor/cache/* deploy@10.0.104.151:/home/deploy/handmade/fss_base/vendor/cache/
ENV_RAILS=production bundle exec rake assets:precompile
echo
echo    !!warning!!
echo    connect to server as deploy and run 'bundle update --local'
echo    to update gems
echo
}
