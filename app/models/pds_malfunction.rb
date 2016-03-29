class PdsMalfunction < ActiveRecord::Base

  #self.inheritance_column = nil
  self.inheritance_column = :_type_disabled
  self.table_name = 'pds_malfunction'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project_unit, foreign_key: 'regidity_unitid'
  
  alias_attribute :system_id, :sys
  alias_attribute :pds_project_unit_id, :regidity_unitid

  has_many :items, class_name: 'PdsMalfunctionDim', foreign_key: :Malfunction

#  def serializable_hash(options={})
#    super options.merge(methods: :id)
#  end

#  def serializable_hash(options={})
#    super.merge({id: id, system: system.to_s})
#  end

  def custom_hash
    serializable_hash(include: {
        system: {only: :System},
        pds_project_unit: {only: [], include: {unit: {only: :Unit_RU}}}
    })
  end

  # todo: add with language
  # (*) – В случае, если длина описания больше 66 символов, то общая длина 2-ой строки обрезается по 72-ой символ и при этом ниже генерятся две
  # служебных строки в виде:
  # @DESC1(1 часть описания (не длиннее 66 символов, разбивается по словам))
  # @DESC2(продолжение описания)
#  def description
#    Desc
#  end

end
