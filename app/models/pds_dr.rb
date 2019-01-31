class PdsDr < ApplicationRecord
  self.table_name = 'pds_dr'
  alias_attribute :id, primary_key

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_engineer_author, foreign_key: :drAuthor, class_name: 'PdsEngineer'
  belongs_to :pds_engineer_closed, foreign_key: :closedBy, class_name: 'PdsEngineer'
  belongs_to :pds_engineer_reply, foreign_key: :replyAuthor, class_name: 'PdsEngineer'
  has_many :pds_dr_comment, dependent: :restrict_with_error, foreign_key: 'pds_dr_id'

  alias_attribute :system_id, :sys
  alias_attribute :pds_engineer_author_id, :drAuthor
  alias_attribute :pds_engineer_closed_id, :closedBy
  alias_attribute :pds_engineer_reply_id, :closedBy
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
      :drNum, :status,
      :reply, 'pds_engineer_replies_pds_dr.engineer_N', 'pds_engineer_replies_pds_dr.name', :replyDate,
      'pds_engineer_closeds_pds_dr.engineer_N', 'pds_engineer_closeds_pds_dr.name', :closedDate)
      .each.map do |e|
      e1 = {}
      e1['id'] = e[0]
      e1['system'] = { id: e[1], System: e[2] }
      e1['pds_engineer_author'] = { id: e[3], name: e[4] }
      e1['query'] = e[5]
      e1['pds_engineer_worker'] = eng_list[e[1]]
      e1['drNum'] = e[6]
      e1['status'] = e[7]
      e1['reply'] = e[8]
      e1['pds_engineer_reply'] = { id: e[9], name: e[10] }
      e1['replyDate'] = e[11]
      e1['pds_engineer_closed'] = { id: e[12], name: e[13] }
      e1['closedDate'] = e[14]
      e = e1
    end
  end

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_engineer_author: { only: :name },
                        pds_engineer_reply: { only: :name },
                        pds_engineer_closed: { only: :name }
                      })
  end
end
