module ApplicationHelper
  def get_tables_list
    YAML.load_file('public/data/tables.yml')
        .each_with_object({}) do |(key, value), hash|
      #  begin
      #    a = link_to 'test', controller: key, action: :index
      hash[key.to_s.pluralize] = value
      #  rescue Exception
      #    Rails.logger.warn "skipping #{key.to_s}"
      #  end
      hash
    end
  end
end
