class PdsMalfunction < ActiveRecord::Base
  # self.inheritance_column = nil
  self.inheritance_column = :_type_disabled
  self.table_name = 'pds_malfunction'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project_unit, foreign_key: 'regidity_unitid'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N'

  alias_attribute :system_id, :sys
  alias_attribute :pds_project_unit_id, :regidity_unitid
  alias_attribute :sd_sys_numb_id, :sd_N

  has_many :items, class_name: 'PdsMalfunctionDim', foreign_key: :Malfunction

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_project_unit: { only: [], include: { unit: { only: :Unit_RU } } },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end

  after_save do |pds_malfunction|
    console
    puts pds_malfunction.id
  end

  # TODO: add with language
  # (*) – В случае, если длина описания больше 66 символов, то общая длина 2-ой строки обрезается по 72-ой символ и при этом ниже генерятся две
  # служебных строки в виде:
  # @DESC1(1 часть описания (не длиннее 66 символов, разбивается по словам))
  # @DESC2(продолжение описания)
  #  def description
  #    Desc
  #  end
end
