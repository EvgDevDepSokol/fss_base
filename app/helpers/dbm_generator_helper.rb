module DbmGeneratorHelper
  # Helper for models with dbm generation

  def unit_for_dbm(is_rus)
    (if is_rus
       !!pds_project_unit ? pds_project_unit.unit.Unit_RU : (defined? regidity_unit) ? regidity_unit : ''
     else
       !!pds_project_unit ? pds_project_unit.unit.Unit_EN : (defined? regidity_unit) ? regidity_unit : ''
     end).unicode_normalize(:nfkd).gsub(%r{[^0-9a-zа-я/%\.\*\+\- ]}i, '')
  end

  def desc12(is_rus)
    desc = if is_rus
             (defined? shortDesc) ? shortDesc : defined? self.Desc || defined? self.Description || ''
           else
             (defined? shortDesc_EN) ? shortDesc_EN : defined? self.Desc_EN || defined? self.Description_EN || ''
           end
    desc = desc ? desc.split.join(' ').strip : ''
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

  def desc12_io(is_rus, desc_io)
    desc = is_rus ? self.Description : self.Description_EN
    desc = desc ? desc.split.join(' ').strip : ''
    desc += (desc_io ? " (#{desc_io})" : '')
    desc = desc ? desc.split.join(' ').strip : ''
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

  def desc12_an(is_rus, ref)
    desc = is_rus ? self.Description : self.Description_EN
    desc = desc ? desc.split.join(' ').strip : ' '
    desc_ref = is_rus ? 'Компонентный отказ ' : 'Component malfunction '
    desc_ref += ref.downcase
    desc_ref = desc_ref.split.join(' ').strip
    @desc0 = '.DESC ' + desc_ref
    if desc.length > 66
      @desc1 = '@DESC1(' + desc[0..desc.rindex(' ', 66) - 1] + ')'
      @desc2 = '@DESC2(' + desc[desc.rindex(' ', 66) + 1..-1] + ')'
    else
      @desc1 = '@DESC1(' + desc[0..64] + ')'
      @desc2 = ''
    end
    nil
  end

  attr_reader :desc0
  attr_reader :desc1
  attr_reader :desc2
end
