RAILS_ENV=production rake assets:clean
RAILS_ENV=production rake assets:clobber
rm -rf ./tmp/cache/
RAILS_ENV=production rake assets:precompile
#RAILS_ENV=production rake assets:precompile
