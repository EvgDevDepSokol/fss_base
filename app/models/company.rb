class Company < ActiveRecord::Base
  self.table_name = 'company'
  has_many :pds_projects

  # logo хранится как bin obj
  def serializable_hash(options={})
    super(except: :Logo, methods: :id)
  end

end
