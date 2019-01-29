class PdsDr < ApplicationRecord
  self.table_name = 'pds_dr'
  alias_attribute :id, primary_key

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_engineer_author, foreign_key: :drAuthor, class_name: 'PdsEngineer'
  alias_attribute :system_id, :sys
  alias_attribute :pds_engineer_author_id, :drAuthor
  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end

  def self.plucked(project_id)
    eng_list = {}
    PdsEngOnSy.where(project: project_id).includes(:pds_engineer).pluck(:sys, 'pds_engineers.name').each.map do |e|
      eng_list[e[0]] = e[1]
    end
    pluck(:id,
      'pds_syslist.SystemID', 'pds_syslist.System',
      'pds_engineers.Engineer_N', 'pds_engineers.name',
      :query,
      :drNum, :status)
      .each.map do |e|
      e1 = {}
      e1['id'] = e[0]
      e1['system'] = { id: e[1], System: e[2] }
      e1['pds_engineer_author'] = { id: e[3], name: e[4] }
      e1['query'] = e[5]
      e1['pds_engineer_worker'] = eng_list[e[1]]
      e1['drNum'] = e[6]
      e1['status'] = e[7]
      e = e1
    end
  end

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_engineer_author: { only: :name }
                      })
  end
end
