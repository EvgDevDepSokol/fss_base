class DwgPanel < ActiveRecord::Base
  alias_attribute :id, self.primary_key
end
