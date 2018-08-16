module DbmGeneratorHelper
  # Helper for models with dbm generation

  def unit_for_dbm(is_rus)
    if is_rus
      !!pds_project_unit ? pds_project_unit.unit.Unit_RU : (defined? regidity_unit) ? regidity_unit : ''
    else
      !!pds_project_unit ? pds_project_unit.unit.Unit_EN : (defined? regidity_unit) ? regidity_unit : ''
    end
  end

  def desc12(is_rus)
    desc = if is_rus
             (defined? shortDesc) ? shortDesc : (defined? self.Desc) ? self.Desc : (defined? self.Description) ? self.Description : ''
           else
             (defined? shortDesc_EN) ? shortDesc_EN : (defined? self.Desc_EN) ? self.Desc_EN : (defined? self.Description_EN) ? self.Description_EN : ''
           end
    desc = desc ? desc.strip : ''
    if desc.length > 66
      @desc0 = '.DESC ' + desc[0..65]
      @desc1 = '@DESC1(' + desc[0..desc.rindex(' ', 66) - 1] + ')'
      @desc2 = '@DESC2(' + desc[desc.rindex(' ', 66) + 1..-1] + ')'
    else
      @desc0 = '.DESC ' + desc
      @desc1 = ''
      @desc2 = ''
    end
    nil
  end

  attr_reader :desc0
  attr_reader :desc1
  attr_reader :desc2
end
