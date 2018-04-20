rake assets:clean
rake assets:clobber
rm -rf ./tmp/cache/
RAILS_ENV=production rake assets:precompile
cp ./app/assets/images/import_export.png ./public/assets/
rails s --binding=0.0.0.0 -e production &
