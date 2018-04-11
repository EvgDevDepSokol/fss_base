# This is for import from lafge excel files
Rack::Utils.key_space_limit = 68_719_476_736 if Rack::Utils.respond_to?('key_space_limit=')
