class PdsRf < ActiveRecord::Base

  self.inheritance_column = nil
  self.table_name = 'pds_rf'

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  alias_attribute :system_id, :sys
  belongs_to :pds_project_unit, foreign_key: :Unit, class_name: 'PdsProjectUnit'
  belongs_to :pds_project, foreign_key: 'Project'

  def serializable_hash(options={})
    super.merge({id: id, system: system.to_s})
  end

  def unit_with_language
    if pds_project.project_properties.language == 'Русский'
      pds_project_unit.unit.ru
    else
      pds_project_unit.unit.en
    end
  end

  def type_b?(t)
    ['B', 'VB'].include?(t)
  end

  def type_i?(t)
    ['I', 'VI'].include?(t)
  end

  def type_r?(t)
    ['R', 'VR'].include?(t)
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
