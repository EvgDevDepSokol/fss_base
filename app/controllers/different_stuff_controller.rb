class DifferentStuffController < ApplicationController
  layout false

  def compare_kursks
    hash = params[:data]
    ref1 = HwIc.where(Project: 80_000_001).pluck(:ref) # old
    ref3 = HwIc.where(Project: 80_000_003).pluck(:ref) # 2014
    pag1 = []
    pag2 = []
    pag3 = []
    list1 = (ref1 - ref3).sort
    list2 = (ref3 - ref1).sort
    list3 = (ref1 - (ref1 - ref3)).sort
    hw_ic_by_ref_arr(80_000_001, list1).each_with_index do |hw_ic, index|
      pag1.push({ ref: list1[index] }.merge(hw_ic))
    end
    hw_ic_by_ref_arr(80_000_003, list2).each_with_index do |hw_ic, index|
      pag2.push({ ref: list2[index] }.merge(hw_ic))
    end
    hw_ic1_arr = hw_ic_by_ref_arr(80_000_001, list3)
    hw_ic3_arr = hw_ic_by_ref_arr(80_000_003, list3)
    hw_ic1_arr.each_with_index do |hw_ic1, index|
      line = {}
      hw_ic3 = hw_ic3_arr[index]
      ref = list3[index]
      next unless hw_ic1 != hw_ic3

      line['ref'] = ref
      line['Сист.'] = hw_ic3['sys']
      hw_ic1.each do |k, v|
        if v != hw_ic3[k]
          line[k] = v
          line[k + '_new'] = hw_ic3[k]
        else
          line[k] = ''
          line[k + '_new'] = ''
        end
      end
      pag3.push(line)
    end
    render json: { status: :ok, pag1: pag1, pag2: pag2, pag3: pag3 }
  end

  def hw_ic_by_ref_arr(proj, ref_arr)
    sql = "SELECT  pds_syslist.System, `hw_ic`.`tag_no`, `hw_ic`.`Description`, hw_peds.ped,hw_devtype.RuName, `hw_ic`.`scaleMin`, `hw_ic`.`scaleMax`, pds_unit.Unit_RU FROM `hw_ic` LEFT OUTER JOIN `pds_project_unit` ON `pds_project_unit`.`ProjUnitID` = `hw_ic`.`Unit` LEFT OUTER JOIN `pds_unit` ON `pds_unit`.`UnitID` = `pds_project_unit`.`Unit` LEFT OUTER JOIN `hw_peds` ON `hw_peds`.`ped_N` = `hw_ic`.`ped` LEFT OUTER JOIN `hw_devtype` ON `hw_devtype`.`typeID` = `hw_peds`.`type` LEFT OUTER JOIN `pds_syslist` ON `pds_syslist`.`SystemID` = `hw_ic`.`sys` WHERE `hw_ic`.`Project` = #{proj} AND `hw_ic`.`ref` in (#{ref_arr.map { |str| "\"#{str}\"" }.join(',')}) order by `hw_ic`.`ref`"
    ActiveRecord::Base.connection.execute(sql).each.map do |e|
      e1 = {}
      e1['sys']              = e[0]
      e1['tag']              = e[1] ? e[1].upcase : e[1]
      e1['desc']             = e[2]
      e1['ped']              = e[3]
      e1['dev']              = e[4]
      e1['min']              = e[5]
      e1['max']              = e[6]
      e1['unit']             = e[7]
      e = e1
    end
  end

  public

  def duplicate_project
    tables = Tablelist.pluck(:table).to_a
    byebug
    tables.each do |tbl_name|
      # e = Object.const_get(tbl_name.classify).where(IC: hw_ic.icID, Project: hw_ic.Project).first
      # Object.const_get(tbl_name.classify)
      if tbl_name.classify.constantize.repond_to?(:project)
      end
    end
  end
end