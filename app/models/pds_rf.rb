class PdsRf < ApplicationRecord
  # self.inheritance_column = nil
  self.inheritance_column = :_type_disabled
  self.table_name = 'pds_rf'
  alias_attribute :id, primary_key

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project_unit, foreign_key: 'Unit', class_name: 'PdsProjectUnit'
  belongs_to :psa_project_unit, foreign_key: 'unit_FB', class_name: 'PdsProjectUnit'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N'

  alias_attribute :system_id, :sys
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :psa_project_unit_id, :unit_FB
  alias_attribute :sd_sys_numb_id, :sd_N

  enum Type_FB: { 'B' => 'B', 'I' => 'I', 'R' => 'R', 'VR' => 'VR', 'VB' => 'VB', 'VI' => 'VI', 'PI' => 'PI' }
  # enum type:    {'B'=>'B','I'=>'I','R'=>'R','VR'=>'VR','VB'=>'VB','VI'=>'VI','PI'=>'PI'}
  enum typerf:  { 'v' => 'v', 'p' => 'p', 'p1' => 'p1' }
  enum scale:   { '1' => '1', '2' => '2' }

  def self.plucked
    pluck(:rfID, :name, :Ptag, :tag_RU, :Desc, :Desc_EN, :range, :type, :range_FB,
      :Type_FB,
      'pds_syslist.SystemID', 'pds_syslist.System',
      'pds_project_unit.ProjUnitID', 'pds_unit.UnitID', 'pds_unit.Unit_RU',
      'psa_project_units_pds_rf.ProjUnitID', 'units_pds_project_unit.UnitID', 'units_pds_project_unit.Unit_RU',
      'sd_sys_numb.sd_N', 'sd_sys_numb.sd_link').map do |e|
      {
        id:                e[0],
        name:              e[1],
        Ptag:              e[2],
        tag_RU:            e[3],
        Desc:              e[4],
        Desc_EN:           e[5],
        range:             e[6],
        type:              e[7],
        range_FB:          e[8],
        Type_FB:           e[9],
        system:            { id: e[10], System: e[11] },
        pds_project_unit:  { id: e[12], unit: { id: e[13], Unit_RU: e[14] } },
        psa_project_unit:  { id: e[15], unit: { id: e[16], Unit_RU: e[17] } },
        sd_sys_numb:       { id: e[18], sd_link: e[19] }
      }
    end
  end

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_project_unit: { only: [], include: { unit: { only: %i[Unit_RU Unit_EN] } } },
                        psa_project_unit: { only: [], include: { unit: { only: %i[Unit_RU Unit_EN] } } },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end

  def unit_with_language
    if pds_project.project_properties.language == 'Русский'
      !!self.Unit ? pds_project_unit.unit.Unit_RU : ''
    else
      !!self.Unit ? pds_project_unit.unit.Unit_EN : ''
    end
  end

  # def unit_with_language
  #  byebug
  #  if pds_project.project_properties.language == 'Русский'
  #    !!self.Unit ? self.custom_hash['pds_project_unit']['unit']['Unit_RU'] : ''
  #  else
  #    !!self.Unit ? self.custom_hash['pds_project_unit']['unit']['Unit_EN'] : ''
  #  end
  # end

  def type_b?(t)
    %w[B VB].include?(t)
  end

  def type_i?(t)
    %w[I VI].include?(t)
  end

  def type_r?(t)
    %w[R VR].include?(t)
  end

  # selection functions
  def var2(type)
    if type_b?(type)
      '2-:'
    elsif type_i?(type)
      '2-i'
    elsif type_r?(type)
      '2-x'
    end
  end

  def selection_type(type)
    if type_b?(type)
      'L,1'
    elsif type_i?(type)
      'I,4'
    elsif type_r?(type)
      'R,4'
    end
  end

  def selection_form(type)
    if type_b?(type)
      'L1'
    elsif type_i?(type)
      ''
    elsif type_r?(type)
      'E13.5'
    end
  end

  def selection_valu(type)
    if type_b?(type)
      'F,V'
    elsif type_i?(type)
      'O,V'
    elsif type_r?(type)
      'O.,V'
    end
  end
end
