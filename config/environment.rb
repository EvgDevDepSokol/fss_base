# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# ActiveRecord::Base.use_pluralization = false
ActiveRecord::Base.pluralize_table_names = true

Mime::Type.register 'text/plain', :sel
