class WeekReport < ActiveRecord::Base

  self.table_name = 'week_report'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_engineer, foreign_key: :Engineer
  alias_attribute :system_id, :sys
  alias_attribute :pds_engineer_id, :Engineer

  def custom_hash
    serializable_hash(include: {
        pds_engineer: { only: :name },
        system: {only: [:System]}})
  end
end
