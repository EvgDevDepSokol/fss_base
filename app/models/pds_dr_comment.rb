# commetn to pds_dr
class PdsDrComment < ApplicationRecord
  self.table_name = 'pds_dr_comment'
  alias_attribute :id, primary_key

  belongs_to :pds_engineer, foreign_key: :comment_author_id, class_name: 'PdsEngineer'
  belongs_to :pds_dr, foreign_key: :pds_dr_id, class_name: 'PdsDr'
  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end

  def custom_hash
    serializable_hash(include: {
                        pds_engineer: { only: :name },
                        pds_dr: {}
                      })
  end
end
