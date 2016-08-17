class PdsRf < ActiveRecord::Base
  # self.inheritance_column = nil
  self.inheritance_column = :_type_disabled
  self.table_name = 'pds_rf'

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project_unit, foreign_key: 'Unit', class_name: 'PdsProjectUnit'
  belongs_to :psa_project_unit, foreign_key: 'unit_FB', class_name: 'PdsProjectUnit'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N'

  alias_attribute :system_id, :sys
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :psa_project_unit_id, :unit_FB
  alias_attribute :sd_sys_numb_id, :sd_N

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_project_unit: { only: [], include: { unit: { only: :Unit_RU } } },
                        psa_project_unit: { only: [], include: { unit: { only: :Unit_RU } } },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end

  def unit_with_language
    if pds_project.project_properties.language == 'Русский'
      pds_project_unit.unit.ru
    else
      pds_project_unit.unit.en
    end
  end

  def type_b?(t)
    %w(B VB).include?(t)
  end

  def type_i?(t)
    %w(I VI).include?(t)
  end

  def type_r?(t)
    %w(R VR).include?(t)
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
