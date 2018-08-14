class Selectors::DbmTblIcsController < ApplicationController
  include SelectorControllerHelper

  def index
    query = "SELECT DISTINCT (tablelist.table), tablelist.title
             FROM
                 hw_ic
                     LEFT OUTER JOIN
                 hw_peds ON hw_ic.ped = ped_n
                     LEFT OUTER JOIN
                 hw_devtype ON hw_peds.type = hw_devtype.typeID
                     LEFT OUTER JOIN
                 tablelist ON typetable = tablelist.tableid
             WHERE
                 hw_ic.project = " + project.ProjectID.to_s + 
             " ORDER BY tablelist.title;"
    @dbm_tbl_ics = ActiveRecord::Base.connection.execute(query)
    do_format(@dbm_tbl_ics)
  end
end
