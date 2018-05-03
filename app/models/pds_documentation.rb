class PdsDocumentation < ApplicationRecord
  self.table_name = 'pds_documentation'
  alias_attribute :id, primary_key

  has_many :pds_blocks, dependent: :restrict_with_error, foreign_key: 'doc'
  has_many :pds_detectors, dependent: :restrict_with_error, foreign_key: 'doc_reg_N'
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'doc_reg_N'
  has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'doc_reg_N'
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'doc_reg_N'
  has_many :pds_doc_on_sys, dependent: :delete_all, foreign_key: 'Doc'

  def self.plucked
    pluck(:id, :DocTitle, :Type, :NPP_Number, :Revision, :reg_ID, :getting_date)
      .each.map do |e|
      x1 = list_of_sys(e[0])
      e1 = {}
      e1['id']                     = e[0]
      e1['DocTitle']               = e[1]
      e1['Type']                   = e[2]
      e1['NPP_number']             = e[3]
      e1['Revision']               = e[4]
      e1['reg_ID']                 = e[5]
      e1['getting_date']           = e[6]
      e1['doc_arr']                = x1
      e = e1
    end
  end

  def custom_hash
    serializable_hash(includes: [:doc_arr]).merge(id: id)
  end

  def self.extra_actions(pds_documentation_id, new_list)
    if !!new_list
      old_list = list_of_sys(pds_documentation_id)['extra_data'][0].to_a
      new_list = new_list.split(',').map(&:to_i).to_a
      (new_list - old_list).each do |sys_id|
        doc_on_sys = PdsDocOnSy.new
        doc_on_sys.Doc = pds_documentation_id
        doc_on_sys.sys = sys_id
        doc_on_sys.save
      end
      (old_list - new_list).each do |sys_id|
        doc_on_sys = PdsDocOnSy.where(Doc: pds_documentation_id, sys: sys_id).to_a
        doc_on_sys.each(&:destroy)
      end
    end
    new_list = {}
    new_list['doc_arr'] = list_of_sys(pds_documentation_id)
    new_list
  end

  def self.list_of_sys(doc_id)
    list={}
    list['extra_data'] = PdsDocOnSy.where(Doc: doc_id).includes(:system).order('pds_syslist.System').pluck('pds_doc_on_sys.sys', 'pds_syslist.System').transpose
    if !!list['extra_data'][1]
      list['extra_label'] = list['extra_data'][1].join(",")
    else
      list['extra_label'] = ''
    end
    list
  end
end
