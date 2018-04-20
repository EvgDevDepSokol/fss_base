rake assets:clean
rake assets:clobber
rm -rf ./tmp/cache/
RAILS_ENV=production rake assets:precompile
rails s --binding=0.0.0.0 -e production &
