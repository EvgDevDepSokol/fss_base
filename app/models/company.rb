class Company < ActiveRecord::Base
  self.table_name = 'company'
  alias_attribute :id, self.primary_key
  has_many :pds_projects

  # logo хранится как bin obj
  def serializable_hash(_options = {})
    super(except: :Logo, methods: :id)
  end
end
