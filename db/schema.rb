# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_150_405_160_632) do
  create_table 'company', primary_key: 'cID', force: true do |t|
    t.string 'shortName',       limit: 64, null: false
    t.string 'shortName_en',    limit: 64
    t.string 'LongName', null: false
    t.string 'LongName_en'
    t.text   'Descriprion',     limit: 16_777_215
    t.binary 'Logo',            limit: 16_777_215
    t.string 'AcceptorPost_en'
    t.string 'AcceptorPost'
    t.string 'AcceptorName_en', limit: 64
    t.string 'AcceptorName',    limit: 64
  end

  create_table 'pds_engineers', primary_key: 'engineer_N', force: true do |t|
    t.string    'name',                limit: 50,                 null: false
    t.string    'TH',                  limit: 1,  default: '0'
    t.boolean   'TO',                             default: false
    t.boolean   'L',                              default: false
    t.boolean   'EL',                             default: false
    t.boolean   'CR',                             default: false
    t.boolean   'D',                              default: false
    t.boolean   'SWM',                            default: false
    t.boolean   'HWM',                            default: false
    t.boolean   'PM',                             default: false
    t.timestamp 't', null: false
    t.string    'EMail', limit: 30
    t.boolean   'CheifDirector', default: false
    t.string    'login',               limit: 50
    t.string    'pwd',                 limit: 40
    t.boolean   'dismiss', default: false
    t.integer   'coreID'
    t.string    'phoneNum',            limit: 11
    t.string    'cellNum',             limit: 32
    t.string    'IP',                  limit: 16
    t.integer   'compJack'
    t.integer   'phoneJack'
    t.integer   'sectorID1'
    t.boolean   'enabled',                        default: true,  null: false
    t.string    'encrypted_password',             default: '',    null: false
    t.datetime  'remember_created_at'
    t.integer   'sign_in_count', default: 0, null: false
    t.datetime  'current_sign_in_at'
    t.datetime  'last_sign_in_at'
    t.string    'current_sign_in_ip'
    t.string    'last_sign_in_ip'
    t.datetime  'created_at'
    t.datetime  'updated_at'
    t.index ['coreID'], name: 'coreID'
    t.index ['engineer_N'], name: 'engineer_N', unique: true
    t.foreign_key ['coreID'], 'core`.`staff', ['ID'], on_update: :cascade, on_delete: :cascade, name: 'pds_engineers_ibfk_1'
  end

  create_table 'tblbinaries', primary_key: 'ObjectID', force: true do |t|
    t.string    'Title'
    t.string    'Type', limit: 25
    t.integer   'Length'
    t.binary    'binObj', limit: 16_777_215
    t.timestamp 't', null: false
    t.index ['ObjectID'], name: 'ObjectID', unique: true
  end

  create_table 'pds_project', primary_key: 'ProjectID', force: true do |t|
    t.string    'project_number',    limit: 50,                null: false
    t.string    'project_name',      limit: 50,                null: false
    t.string    'project_name_EN'
    t.string    'Contractor', null: false
    t.integer   'companyID'
    t.string    'contract_number', limit: 64, default: ''
    t.date      'contract_date'
    t.integer   'ProjectManager'
    t.integer   'SWManager'
    t.integer   'HWManager'
    t.string    'Factor',            limit: 50
    t.string    'Description',       limit: 1000
    t.text      'Description_EN'
    t.string    'Notes', limit: 1000
    t.integer   'BlobObj'
    t.timestamp 't', null: false
    t.date      'contract_end_date'
    t.index ['BlobObj'], name: 'Logo'
    t.index ['HWManager'], name: 'HWManager'
    t.index ['ProjectID'], name: 'ProjectID', unique: true
    t.index ['ProjectManager'], name: 'ProjectManager'
    t.index ['SWManager'], name: 'SWManager'
    t.index ['companyID'], name: 'fk_company'
    t.index %w(project_number project_name), name: 'project_number', unique: true
    t.foreign_key ['BlobObj'], 'tblbinaries', ['ObjectID'], on_update: :cascade, on_delete: :set_null, name: 'pds_project_ibfk_6'
    t.foreign_key ['HWManager'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :no_action, name: 'pds_project_ibfk_7'
    t.foreign_key ['ProjectManager'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :no_action, name: 'pds_project_ibfk_8'
    t.foreign_key ['SWManager'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :no_action, name: 'pds_project_ibfk_9'
    t.foreign_key ['companyID'], 'company', ['cID'], on_update: :cascade, on_delete: :restrict, name: 'fk_company'
  end

  create_table 'dwg_panels', primary_key: 'dp_id', force: true do |t|
    t.integer   'Project', null: false
    t.boolean   'panel', default: true, null: false
    t.string    'NAME',       limit: 33
    t.string    'EV',         limit: 4
    t.integer   'EH',         limit: 1
    t.string    'SV',         limit: 4
    t.integer   'SH',         limit: 1
    t.string    'MP_CMEMO',   limit: 256
    t.string    'MP_CODE',    limit: 33
    t.string    'MP_CODE1'
    t.string    'MP_CODE2'
    t.string    'MP_L0'
    t.string    'MP_L0_0',    limit: 127
    t.string    'MP_L0_1',    limit: 127
    t.string    'MP_L0_2',    limit: 127
    t.string    'MP_L0_3',    limit: 127
    t.string    'MP_L0_4',    limit: 127
    t.integer   'MP_L0_0_x'
    t.integer   'MP_L0_0_y'
    t.integer   'MP_L0_0_w'
    t.integer   'MP_L0_0_h'
    t.integer   'MP_L0_0_f'
    t.integer   'MP_L0_1_x'
    t.integer   'MP_L0_1_y'
    t.integer   'MP_L0_1_w'
    t.integer   'MP_L0_1_h'
    t.integer   'MP_L0_1_f'
    t.integer   'MP_L0_2_x'
    t.integer   'MP_L0_2_y'
    t.integer   'MP_L0_2_w'
    t.integer   'MP_L0_2_h'
    t.integer   'MP_L0_2_f'
    t.integer   'MP_L0_3_x'
    t.integer   'MP_L0_3_y'
    t.integer   'MP_L0_3_w'
    t.integer   'MP_L0_3_h'
    t.integer   'MP_L0_3_f'
    t.integer   'MP_L0_4_x'
    t.integer   'MP_L0_4_y'
    t.integer   'MP_L0_4_w'
    t.integer   'MP_L0_4_h'
    t.integer   'MP_L0_4_f'
    t.integer   'MP_MASS',    limit: 1
    t.float     'MP_MAX',     limit: 53
    t.float     'MP_MIN',     limit: 53
    t.string    'MP_MODE',    limit: 4
    t.integer   'MP_MODEORD', limit: 1
    t.string    'MP_NAME0',   limit: 64
    t.string    'MP_NAME1',   limit: 64
    t.string    'MP_ORDER',   limit: 32
    t.integer   'MP_PROJ'
    t.integer   'MP_S0'
    t.integer   'MP_S100'
    t.integer   'MP_S20'
    t.integer   'MP_S40'
    t.integer   'MP_S50'
    t.string    'MP_S60', limit: 32
    t.integer   'MP_S80'
    t.string    'MP_TYPE0',   limit: 32
    t.string    'MP_TYPE1',   limit: 32
    t.string    'MP_U0',      limit: 8
    t.string    'MP_U1',      limit: 8
    t.string    'MP_IO',      limit: 8
    t.string    'MP_IOCONT',  limit: 8
    t.string    'MP_IONAME',  limit: 8
    t.string    'TYPE',       limit: 32
    t.decimal   'FONT', precision: 5, scale: 2
    t.integer   'MIRROR', limit: 1
    t.decimal   'ROTATE', precision: 6, scale: 2
    t.integer   'revision',                                                      null: false
    t.timestamp 't',                                                             null: false
    t.integer   'rotation', default: 0
    t.string    'ref', limit: 32
    t.index ['MP_TYPE1'], name: 'ped_index'
    t.index ['MP_U0'], name: 'unit_index'
    t.index ['NAME'], name: 'panel_index'
    t.index ['Project'], name: 'FK_dwg_panels1'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'FK_dwg_panels1'
  end

  create_view 'acc', "(select `dwg_panels`.`Project` AS `Project`,`dwg_panels`.`MP_TYPE0` AS `ped`,convert(`dwg_panels`.`NAME` using utf8) AS `Name`,`dwg_panels`.`SH` AS `number`,convert(`dwg_panels`.`SH` using utf8) AS `SH`,convert(`dwg_panels`.`SV` using utf8) AS `SV`,concat_ws(',',`dwg_panels`.`MP_CODE`,convert(`dwg_panels`.`MP_CODE1` using utf8),convert(`dwg_panels`.`MP_CODE2` using utf8)) AS `tag_no`,`dwg_panels`.`MP_L0` AS `store`,(case when isnull(`dwg_panels`.`MP_MIN`) then `dwg_panels`.`MP_S0` else `dwg_panels`.`MP_MIN` end) AS `scale_min`,(case when isnull(`dwg_panels`.`MP_MAX`) then `dwg_panels`.`MP_S100` else `dwg_panels`.`MP_MAX` end) AS `scale_max`,`dwg_panels`.`MP_U0` AS `Unit`,`dwg_panels`.`MP_CMEMO` AS `MP_CMEMO`,`dwg_panels`.`NAME` AS `panel`,`dwg_panels`.`revision` AS `revision`,`dwg_panels`.`MP_TYPE0` AS `MP_TYPE0` from `dwg_panels` where ((locate('-1',`dwg_panels`.`MP_TYPE0`) = 0) and (`dwg_panels`.`MP_TYPE0` is not null) and (not((`dwg_panels`.`MP_TYPE0` like 'не%'))) and (`dwg_panels`.`revision` = (select max(`t1`.`revision`) AS `max(revision)` from `dwg_panels` `t1` where ((`t1`.`Project` = `dwg_panels`.`Project`) and (`t1`.`NAME` = `dwg_panels`.`NAME`))))))", force: true
  create_view 'acc_ic', "(select `dwg_panels`.`Project` AS `Project`,`dwg_panels`.`ref` AS `ref`,`dwg_panels`.`MP_TYPE0` AS `ped`,group_concat(concat_ws(',',`dwg_panels`.`MP_CODE`,convert(`dwg_panels`.`MP_CODE1` using utf8),convert(`dwg_panels`.`MP_CODE2` using utf8)) separator ',') AS `tag_no`,`dwg_panels`.`MP_L0` AS `Надпись`,(case when isnull(`dwg_panels`.`MP_MIN`) then `dwg_panels`.`MP_S0` else `dwg_panels`.`MP_MIN` end) AS `scale_min`,(case when isnull(`dwg_panels`.`MP_MAX`) then `dwg_panels`.`MP_S100` else `dwg_panels`.`MP_MAX` end) AS `scale_max`,`dwg_panels`.`MP_U0` AS `Unit`,`dwg_panels`.`MP_CMEMO` AS `MP_CMEMO`,`dwg_panels`.`NAME` AS `panel`,`dwg_panels`.`revision` AS `revision` from `dwg_panels` where ((locate('-10',`dwg_panels`.`MP_TYPE0`) = 0) and (not((`dwg_panels`.`MP_TYPE0` like 'не%'))) and (`dwg_panels`.`revision` = 1)) group by `dwg_panels`.`Project`,`dwg_panels`.`ref` order by `dwg_panels`.`SV`,`dwg_panels`.`SH`)", force: true
  create_table 'as', force: true do |t|
    t.string 'a', limit: 32
    t.string 'b', limit: 32
  end

  create_table 'audit', primary_key: 'auditID', force: true do |t|
    t.integer   'Project',                  null: false
    t.string    'table_name',    limit: 64, null: false
    t.string    'tag_RU',        limit: 64
    t.string    'tag_EN',        limit: 64
    t.string    'sys',           limit: 64
    t.string    'field_changed', limit: 64, null: false
    t.integer   'id',                       null: false
    t.text      'old_value'
    t.text      'new_value'
    t.timestamp 't', null: false
    t.index ['Project'], name: 'PRJ_KEY'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :cascade, name: 'PRJ_KEY'
  end

  create_table 'contract', primary_key: 'ID', force: true do |t|
    t.string  'contr_Num', limit: 64, null: false
    t.integer 'Project',              null: false
    t.string  'state', limit: 21
    t.date    'date'
    t.string  'Desc'
    t.index ['Project'], name: 'Project'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :cascade, name: 'contract_ibfk_1'
  end

  create_table 'pds_man_equip', primary_key: 'EquipN', force: true do |t|
    t.string    'Type',       limit: 3, null: false
    t.string    'Descriptor', limit: 100
    t.string    'Contr_win',  limit: 1,                 null: false
    t.string    'Over_menu',  limit: 1,                 null: false
    t.string    'Comp_malf',  limit: 3, default: '-'
    t.timestamp 't', null: false
    t.index ['EquipN'], name: 'EquipN', unique: true
    t.index ['Type'], name: 'Type', unique: true
  end

  create_table 'pds_syslist', primary_key: 'SystemID', force: true do |t|
    t.string    'System',       limit: 8, default: '', null: false
    t.string    'Descriptor',   limit: 4
    t.string    'Category',     limit: 1
    t.text      'shortDesc'
    t.text      'shortDesc_EN'
    t.timestamp 't', null: false
    t.index ['System'], name: 'System', unique: true
    t.index ['SystemID'], name: 'SystemID', unique: true
  end

  create_table 'pds_sd', primary_key: 'sd_N', force: true do |t|
    t.string    'SdTitle',               null: false
    t.integer   'sys',                   null: false
    t.integer   'Project',               null: false
    t.string    'title_EN'
    t.string    'Numb', limit: 3, null: false
    t.integer   'BlobObj'
    t.timestamp 't', null: false
    t.timestamp 'from_sapfir'
    t.index ['BlobObj'], name: 'Image'
    t.index ['Project'], name: 'Project'
    t.index ['sd_N'], name: 'sd_N', unique: true
    t.index ['sys'], name: 'sys'
    t.foreign_key ['BlobObj'], 'tblbinaries', ['ObjectID'], on_update: :cascade, on_delete: :set_null, name: 'pds_sd_ibfk_7'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_sd_ibfk_6'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_sd_ibfk_5'
  end

  create_table 'pds_section_assembler', primary_key: 'section_N', force: true do |t|
    t.integer   'Project', null: false
    t.string    'section_name',  limit: 32
    t.string    'assembler',     limit: 32
    t.timestamp 't', null: false
    t.string    'assembler_pwr', limit: 32
    t.string    'assembler_ec',  limit: 32
    t.index ['Project'], name: 'Project'
    t.index ['section_N'], name: 'section_N', unique: true
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_section_assembler_ibfk_1'
  end

  create_table 'pds_breakers', primary_key: 'BreakerID', force: true do |t|
    t.integer 'sys'
    t.integer 'Project', null: false
    t.string  'tag_RU', default: ''
    t.string  'tag_EN'
    t.integer 'ed_power'
    t.integer 'ctrl_power'
    t.integer 'anc_power'
    t.float   'Time',       limit: 53
    t.string  'Algorithm',  limit: 50
    t.string  'Desc_RU'
    t.string  'Desc_EN'
    t.string  'model', limit: 64
    t.integer 'eq_type'
    t.string  'connection', limit: 64
    t.integer 'sd_N'
    t.index ['BreakerID'], name: 'BreakerID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['anc_power'], name: 'anc_power'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['ed_power'], name: 'FK_pds_breakers_ed_power1'
    t.index ['eq_type'], name: 'FK_pds_breakers_eq_type1'
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_breakers_ibfk_5'
    t.foreign_key ['anc_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_breakers_ibfk_7'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_breakers_ibfk_6'
    t.foreign_key ['ed_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_breakers_ed_power1'
    t.foreign_key ['eq_type'], 'pds_man_equip', ['EquipN'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_breakers_eq_type1'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_breakers_sd_N'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_breakers_ibfk_1'
  end

  create_table 'pds_documentation', primary_key: 'DocID', force: true do |t|
    t.integer   'Project', null: false
    t.string    'Type'
    t.string    'NPP_Number'
    t.string    'Revision', limit: 50
    t.string    'reg_ID', default: ''
    t.date      'getting_date'
    t.text      'DocTitle'
    t.text      'DocTitle_EN'
    t.boolean   'Hardcopy', default: false
    t.string    'File'
    t.timestamp 't', null: false
    t.index ['DocID'], name: 'DocID', unique: true
    t.index ['File'], name: 'DocObject'
    t.index ['Project'], name: 'Project'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_documentation_ibfk_5'
  end

  create_table 'pds_unit', primary_key: 'UnitID', force: true do |t|
    t.string    'Unit_RU',    limit: 15, null: false
    t.string    'Unit_EN',    limit: 15, null: false
    t.float     'MultFactor', limit: 53
    t.float     'ZeroShift',  limit: 53
    t.timestamp 't', null: false
    t.timestamp 'import_t'
    t.index ['UnitID'], name: 'UnitID', unique: true
    t.index ['Unit_EN'], name: 'Unit_EN', unique: true
    t.index ['Unit_RU'], name: 'Unit_RU', unique: true
  end

  create_table 'pds_project_unit', primary_key: 'ProjUnitID', force: true do |t|
    t.integer   'Project', null: false
    t.integer   'Unit',    null: false
    t.timestamp 't',       null: false
    t.index ['ProjUnitID'], name: 'ProjUnitID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['Unit'], name: 'Unit'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_project_unit_ibfk_3'
    t.foreign_key ['Unit'], 'pds_unit', ['UnitID'], on_update: :cascade, on_delete: :restrict, name: 'pds_project_unit_ibfk_4'
  end

  create_table 'pds_detectors', primary_key: 'DetID', force: true do |t|
    t.integer   'Project', null: false
    t.integer   'sys'
    t.string    'station_sys', limit: 30
    t.string    'tag', default: ''
    t.string    'tag_RU'
    t.string    'Desc'
    t.string    'Desc_EN'
    t.string    'Group_N', limit: 30
    t.integer   'ctrl_power'
    t.string    'nom_state',    limit: 32
    t.float     'low_lim',      limit: 53
    t.float     'up_lim',       limit: 53
    t.float     'LA',           limit: 53
    t.float     'HA',           limit: 53
    t.float     'LW',           limit: 53
    t.float     'HW',           limit: 53
    t.float     'LT',           limit: 53
    t.float     'HT',           limit: 53
    t.integer   'Unit'
    t.float     '1coef_shift',  limit: 53
    t.float     '2coef_scale',  limit: 53
    t.float     'sluggishness', limit: 53
    t.float     'scale_noise',  limit: 53
    t.integer   'sd_N'
    t.integer   'doc_reg_N'
    t.string    'Func', limit: 1000
    t.timestamp 't', null: false
    t.string    'Type',         limit: 2, default: 'AI'
    t.string    'TypeDetec',    limit: 20
    t.string    'Room',         limit: 155
    t.string    'SPTable',      limit: 350
    t.string    'SCK_input',    limit: 20
    t.string    'SP_1',         limit: 64
    t.string    'SP_2',         limit: 64
    t.string    'SP_3',         limit: 64
    t.string    'SPT_ACTION',   limit: 150
    t.string    'SPT_COMMENT',  limit: 100
    t.string    'DREG_input',   limit: 10
    t.integer   'TimeConst'
    t.integer   'power', limit: 1, default: 0
    t.string    'varible'
    t.timestamp 'import_t'
    t.string    'mod'
    t.integer   'eq_type'
    t.string    'alg_type', limit: 16
    t.index ['DetID'], name: 'DetID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['Unit'], name: 'Unit'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['doc_reg_N'], name: 'doc_reg_N'
    t.index ['eq_type'], name: 'FK_pds_detectors_eq_type1'
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_detectors_ibfk_14'
    t.foreign_key ['Unit'], 'pds_project_unit', ['ProjUnitID'], on_update: :cascade, on_delete: :set_null, name: 'pds_detectors_ibfk_19'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_detectors_ibfk_18'
    t.foreign_key ['doc_reg_N'], 'pds_documentation', ['DocID'], on_update: :cascade, on_delete: :set_null, name: 'pds_detectors_ibfk_16'
    t.foreign_key ['eq_type'], 'pds_man_equip', ['EquipN'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_detectors_eq_type1'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_detectors_ibfk_17'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_detectors_ibfk_10'
  end

  create_table 'pds_motor_type', primary_key: 'MotorTypeID', force: true do |t|
    t.string    'MotorType'
    t.float     'I_nom',          limit: 53
    t.float     'U_nom',          limit: 53
    t.float     'nom_pressure',   limit: 53
    t.float     'nom_water_rate', limit: 53
    t.float     'N_nom',          limit: 53
    t.float     'cos',            limit: 53
    t.float     'up_rate',        limit: 53
    t.float     'down_rate',      limit: 53
    t.float     'Coeff1',         limit: 53
    t.float     'Coeff2',         limit: 53
    t.float     'Coeff3',         limit: 53
    t.timestamp 't', null: false
    t.index ['MotorTypeID'], name: 'MotorTypeID', unique: true
  end

  create_table 'pds_motors', primary_key: 'MotID', force: true do |t|
    t.integer   'Project', null: false
    t.integer   'MotorType'
    t.integer   'sys'
    t.string    'station_sys',    limit: 120
    t.string    'tag_RU',         limit: 50
    t.string    'tag_EN',         limit: 50
    t.string    'Desc_RU'
    t.string    'Desc_EN'
    t.integer   'ed_power'
    t.integer   'ctrl_power'
    t.integer   'anc_power'
    t.string    'room',           limit: 32
    t.string    'elevation',      limit: 32
    t.integer   'Stopway'
    t.boolean   'nom_state', default: false
    t.float     'lim_power',      limit: 53
    t.float     'effeciency',     limit: 53
    t.float     'rotation_speed', limit: 53
    t.integer   'sd_N'
    t.integer   'doc_reg_N'
    t.timestamp 't', null: false
    t.float     'up_rate',        limit: 53
    t.float     'down_rate',      limit: 53
    t.string    'zmn',            limit: 14
    t.string    'model',          limit: 64
    t.string    'type_temp',      limit: 32
    t.float     'voltage',        limit: 24
    t.string    'RTZO_OLD1',      limit: 16
    t.string    'RTZO_OLD2',      limit: 16
    t.string    'RTZO_NEW1',      limit: 16
    t.string    'RTZO_NEW2',      limit: 16
    t.decimal   'p_ust',                      precision: 15, scale: 3
    t.decimal   'i_nom',                      precision: 7,  scale: 1
    t.timestamp 'import_t'
    t.string    'mod'
    t.integer   'eq_type'
    t.string    'connection',     limit: 16
    t.string    'Algorithm',      limit: 80
    t.integer   'power_section'
    t.index ['MotID'], name: 'MotID', unique: true
    t.index ['MotorType'], name: 'MotorType'
    t.index ['Project'], name: 'Project'
    t.index ['anc_power'], name: 'anc_power'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['doc_reg_N'], name: 'doc_reg_N'
    t.index ['ed_power'], name: 'ed_power'
    t.index ['eq_type'], name: 'FK_pds_motors_eq_type'
    t.index ['power_section'], name: 'power_section'
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['MotorType'], 'pds_motor_type', ['MotorTypeID'], on_update: :cascade, on_delete: :no_action, name: 'pds_motors_ibfk_32'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_motors_ibfk_33'
    t.foreign_key ['anc_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_motors_ibfk_31'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_motors_ibfk_30'
    t.foreign_key ['doc_reg_N'], 'pds_documentation', ['DocID'], on_update: :cascade, on_delete: :restrict, name: 'pds_motors_ibfk_27'
    t.foreign_key ['ed_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_motors_ibfk_29'
    t.foreign_key ['eq_type'], 'pds_man_equip', ['EquipN'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_motors_eq_type'
    t.foreign_key ['power_section'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_motors_ibfk_34'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :restrict, name: 'pds_motors_ibfk_28'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_motors_ibfk_26'
  end

  create_table 'pds_valves', primary_key: 'valveID', force: true do |t|
    t.integer   'Project', null: false
    t.integer   'sys'
    t.string    'tag_RU'
    t.string    'tag_EN'
    t.string    'PowerTemp',     limit: 50
    t.string    'Type',          limit: 10
    t.string    'station_sys',   limit: 128
    t.string    'Desc', default: '', null: false
    t.string    'Desc_EN'
    t.string    'Department', limit: 10
    t.integer   'ed_power'
    t.integer   'ctrl_power'
    t.integer   'anc_power'
    t.float     'nom_state',     limit: 53
    t.float     'open_rate',     limit: 53
    t.float     'close_rate',    limit: 53
    t.integer   'sd_N'
    t.integer   'doc_reg_N'
    t.string    'Algorithm', limit: 80
    t.timestamp 't', null: false
    t.string    'model', limit: 64
    t.timestamp 'import_t'
    t.string    'mod'
    t.integer   'eq_type'
    t.decimal   'level', precision: 10, scale: 5
    t.string    'room',          limit: 32
    t.string    'panels',        limit: 64
    t.string    'connection',    limit: 16
    t.integer   'power_section'
    t.index ['Project'], name: 'Project'
    t.index ['anc_power'], name: 'anc_power'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['doc_reg_N'], name: 'doc_reg_N'
    t.index %w(ed_power ctrl_power anc_power), name: 'ed_power_2'
    t.index ['ed_power'], name: 'ed_power'
    t.index ['eq_type'], name: 'FK_pds_valves_eq'
    t.index ['power_section'], name: 'power_section'
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'sys'
    t.index ['valveID'], name: 'valveID', unique: true
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_valves_ibfk_29'
    t.foreign_key ['anc_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_valves_ibfk_27'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_valves_ibfk_26'
    t.foreign_key ['doc_reg_N'], 'pds_documentation', ['DocID'], on_update: :cascade, on_delete: :restrict, name: 'pds_valves_ibfk_25'
    t.foreign_key ['ed_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_valves_ibfk_28'
    t.foreign_key ['eq_type'], 'pds_man_equip', ['EquipN'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_valves_eq'
    t.foreign_key ['power_section'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_valves_ibfk_30'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :restrict, name: 'pds_valves_ibfk_24'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_valves_ibfk_23'
  end

  create_view 'detectors_valves_motors_breakers_85', "select `pds_detectors`.`tag` AS `tag`,'pds_detectors' AS `table` from `pds_detectors` where (`pds_detectors`.`Project` = 340000001) union select `pds_valves`.`tag_EN` AS `tag`,concat('pds_valves',' ',ifnull(`pds_valves`.`Type`,'')) AS `table` from `pds_valves` where ((`pds_valves`.`Project` = 340000001) and (isnull(`pds_valves`.`Type`) or ((`pds_valves`.`Type` <> 'vlv_check') and (`pds_valves`.`Type` <> 'vlv_relief')))) union select `pds_motors`.`tag_EN` AS `tag`,'pds_motors' AS `table` from `pds_motors` where (`pds_motors`.`Project` = 340000001) union select `pds_breakers`.`tag_EN` AS `tag`,'pds_breakers' AS `table` from `pds_breakers` where (`pds_breakers`.`Project` = 340000001)", force: true
  create_table 'pds_filter', primary_key: 'filterID', force: true do |t|
    t.string  'kks',       limit: 15, null: false
    t.string  'ShortDesc', limit: 80
    t.text    'Desc_EN'
    t.float   'level',     limit: 24
    t.string  'room',      limit: 32
    t.integer 'Project', null: false
    t.integer 'sys'
    t.integer 'eq_type'
    t.string  'var',       limit: 64
    t.string  'old_var',   limit: 64
    t.integer 'sd_N'
    t.index ['Project'], name: 'FK_pds_filter'
    t.index ['eq_type'], name: 'FK_pds_filter_eq_type'
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'FK_pds_filter_sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :cascade, name: 'FK_pds_filter'
    t.foreign_key ['eq_type'], 'pds_man_equip', ['EquipN'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_filter_eq_type'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :restrict, name: 'FK_pds_filter_sd_N'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :cascade, on_delete: :cascade, name: 'FK_pds_filter_sys'
  end

  create_table 'pds_hex', primary_key: 'hexID', force: true do |t|
    t.string  'kks',       limit: 15, null: false
    t.string  'ShortDesc', limit: 80
    t.float   's',         limit: 24
    t.float   'level',     limit: 24
    t.string  'room',      limit: 15
    t.integer 'Project', null: false
    t.integer 'sys'
    t.integer 'eq_type'
    t.string  'var',       limit: 64
    t.string  'old_var',   limit: 64
    t.text    'Desc_EN'
    t.integer 'sd_N'
    t.index ['Project'], name: 'FK_pds_hex'
    t.index ['eq_type'], name: 'FK_pds_hex_eq_type'
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'FK_pds_hex_sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :cascade, name: 'FK_pds_hex'
    t.foreign_key ['eq_type'], 'pds_man_equip', ['EquipN'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_hex_eq_type'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :restrict, name: 'FK_pds_hex_sd_N'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :cascade, on_delete: :cascade, name: 'FK_pds_hex_sys'
  end

  create_table 'pds_rf', primary_key: 'rfID', force: true do |t|
    t.integer   'sys'
    t.integer   'Project', null: false
    t.string    'name_RU',  limit: 32
    t.string    'name',     limit: 32, null: false
    t.string    'tag_RU',   limit: 32
    t.string    'Desc', default: ''
    t.string    'Desc_EN'
    t.string    'range', limit: 128, default: ''
    t.integer   'Unit'
    t.string    'type',     limit: 2
    t.string    'Type_FB',  limit: 2
    t.integer   'unit_FB'
    t.string    'range_FB', limit: 128
    t.float     'rate',     limit: 53
    t.string    'Ptag',     limit: 30
    t.integer   'sd_N'
    t.timestamp 't', null: false
    t.string    'typerf',   limit: 2
    t.string    'scale',    limit: 1
    t.integer   'frfID'
    t.index ['Project'], name: 'Project'
    t.index ['Unit'], name: 'unit'
    t.index ['frfID'], name: 'FK_pds_rf'
    t.index ['rfID'], name: 'rfID', unique: true
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'sys'
    t.index ['unit_FB'], name: 'unit_FB'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_rf_ibfk_14'
    t.foreign_key ['Unit'], 'pds_project_unit', ['ProjUnitID'], on_update: :cascade, on_delete: :restrict, name: 'pds_rf_ibfk_12'
    t.foreign_key ['frfID'], 'pds_rf', ['rfID'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_rf'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_rf_ibfk_15'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_rf_ibfk_10'
    t.foreign_key ['unit_FB'], 'pds_project_unit', ['ProjUnitID'], on_update: :cascade, on_delete: :restrict, name: 'pds_rf_ibfk_13'
  end

  create_table 'pds_volume', primary_key: 'volumeID', force: true do |t|
    t.string  'kks',       limit: 15, null: false
    t.string  'ShortDesc', limit: 80
    t.text    'Desc_EN'
    t.float   'volume',    limit: 24
    t.float   'height',    limit: 24
    t.float   'level',     limit: 24
    t.string  'room',      limit: 15
    t.integer 'Project', null: false
    t.integer 'sys'
    t.integer 'eq_type'
    t.integer 'sd_N'
    t.index ['Project'], name: 'FK_pds_volume'
    t.index ['eq_type'], name: 'FK_pds_volume_eq_type'
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'FK_pds_volume_sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :cascade, name: 'FK_pds_volume'
    t.foreign_key ['eq_type'], 'pds_man_equip', ['EquipN'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_volume_eq_type'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :restrict, name: 'FK_pds_volume_sd_N'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :cascade, on_delete: :cascade, name: 'FK_pds_volume_sys'
  end

  create_view 'detectors_valves_motors_breakers_filter_hex_rf_volume_85', "select `pds_detectors`.`tag` AS `tag`,'pds_detectors' AS `table` from `pds_detectors` where (`pds_detectors`.`Project` = 340000001) union select `pds_valves`.`tag_EN` AS `tag`,'pds_valves' AS `table` from `pds_valves` where (`pds_valves`.`Project` = 340000001) union select `pds_motors`.`tag_EN` AS `tag`,'pds_motors' AS `table` from `pds_motors` where (`pds_motors`.`Project` = 340000001) union select `pds_breakers`.`tag_EN` AS `tag`,'pds_breakers' AS `table` from `pds_breakers` where (`pds_breakers`.`Project` = 340000001) union select `pds_filter`.`kks` AS `kks`,'pds_filter' AS `table` from `pds_filter` where (`pds_filter`.`Project` = 340000001) union select `pds_hex`.`kks` AS `tag`,'pds_hex' AS `table` from `pds_hex` where (`pds_hex`.`Project` = 340000001) union select `pds_rf`.`name` AS `tag`,'pds_rf' AS `table` from `pds_rf` where (`pds_rf`.`Project` = 340000001) union select `pds_volume`.`kks` AS `tag`,'pds_volume' AS `table` from `pds_volume` where (`pds_volume`.`Project` = 340000001)", force: true
  create_table 'pds_dr', primary_key: 'drID', force: true do |t|
    t.integer  'sys'
    t.integer  'Project',                       null: false
    t.integer  'drNum',                         null: false
    t.string   'stage',            limit: 32
    t.string   'drAuthor_text',    limit: 32
    t.integer  'drAuthor'
    t.boolean  'rfr'
    t.boolean  'closed'
    t.datetime 'createDate'
    t.datetime 'expRespDate'
    t.text     'query'
    t.text     'reply'
    t.text     'sentForRev'
    t.string   'replyAuthor_text', limit: 32
    t.integer  'replyAuthor'
    t.integer  'closedBy'
    t.datetime 'openedDate'
    t.datetime 'inprogressDate'
    t.datetime 'replyDate'
    t.datetime 'closedDate'
    t.string   'NameDr',           limit: 64
    t.string   'Status',           limit: 17
    t.integer  'IC'
    t.string   'PowerState',       limit: 32
    t.string   'Priority',         limit: 16
    t.string   'Disparity',        limit: 1024
    t.string   'CommingResult',    limit: 1024
    t.index %w(Project drNum), name: 'UniqueDrnum', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['closedBy'], name: 'NewIndex2'
    t.index ['drAuthor'], name: 'drAuthor'
    t.index ['drID'], name: 'drID', unique: true
    t.index ['replyAuthor'], name: 'NewIndex1'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_dr_ibfk_2'
    t.foreign_key ['closedBy'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_dr_5'
    t.foreign_key ['drAuthor'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_dr_3'
    t.foreign_key ['replyAuthor'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_dr_4'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_dr_ibfk_1'
  end

  create_view 'dr_stats', '(select `pds_dr`.`Project` AS `Project`,`pds_dr`.`sys` AS `sys`,(select `pds_syslist`.`System` AS `System` from `pds_syslist` where (`pds_dr`.`sys` = `pds_syslist`.`SystemID`)) AS `sysname`,(select `get_sys_eng`(`pds_dr`.`sys`,`pds_dr`.`Project`) AS ```pds_db``.``get_sys_eng``(``pds_dr``.``sys``, ``pds_dr``.``Project``)`) AS `sys_eng_name`,`pds_dr`.`Status` AS `Status`,count(1) AS `number` from `pds_dr` group by `pds_dr`.`Project`,`pds_dr`.`sys`,`pds_dr`.`Status` order by `pds_dr`.`Project`,`pds_dr`.`sys`)', force: true
  create_table 'dwg_type_rotations', primary_key: 'tr_id', force: true do |t|
    t.integer 'Project'
    t.string  'type', limit: 128, null: false
    t.integer 'rotation'
    t.integer 'reflection'
    t.index ['Project'], name: 'FK_dwg_type_rotations'
    t.index ['Project'], name: 'FK_dwg_type_rotations1'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'FK_dwg_type_rotations1'
  end

  create_table 'tablelist', primary_key: 'tableID', force: true do |t|
    t.string  'table',   limit: 50
    t.string  'title',   limit: 50
    t.string  'Desc'
    t.integer 'BlobObj'
    t.integer 'number', null: false
    t.index ['table'], name: 'table', unique: true
    t.index ['tableID'], name: 'TableID', unique: true
  end

  create_table 'hw_devtype', primary_key: 'typeID', force: true do |t|
    t.string  'RuName',    limit: 31
    t.string  'EnName',    limit: 31
    t.integer 'typetable', limit: 1
    t.index ['typeID'], name: 'typeID', unique: true
    t.index ['typetable'], name: 'typetable'
    t.foreign_key ['typetable'], 'tablelist', ['tableID'], on_update: :restrict, on_delete: :restrict, name: 'hw_devtype_ibfk_1'
  end

  create_table 'hw_peds', primary_key: 'ped_N', force: true do |t|
    t.integer   'Project',                             null: false
    t.string    'ped',       limit: 32, default: '',   null: false
    t.string    'Code',      limit: 50
    t.integer   'AI',                   default: 0
    t.integer   'AO',                   default: 0
    t.integer   'AO*',                  default: 0
    t.integer   'DI',                   default: 0
    t.integer   'LO',                   default: 0
    t.integer   'LO*',                  default: 0
    t.integer   'LO+',                  default: 0
    t.integer   'LO220',                default: 0
    t.integer   'RO',                   default: 0
    t.integer   'DO',                   default: 0
    t.integer   'IOSUM'
    t.float     '5VDC',      limit: 53, default: 0.0
    t.float     '24VDC',     limit: 53, default: 0.0
    t.float     '10VDC',     limit: 53, default: 0.0
    t.float     '12VDC',     limit: 53, default: 0.0
    t.float     '60VDC',     limit: 53, default: 0.0
    t.float     '100VDC',    limit: 53, default: 0.0
    t.float     '9VDC',      limit: 53, default: 0.0
    t.float     '220VAC',    limit: 53, default: 0.0
    t.float     '1,2VAC',    limit: 53, default: 0.0
    t.float     '1,5VAC',    limit: 53, default: 0.0
    t.float     '2,5VAC',    limit: 53, default: 0.0
    t.float     '5VAC',      limit: 53, default: 0.0
    t.integer   'type'
    t.string    'VENDOR',    limit: 30
    t.string    'DESCRIPT',  limit: 64
    t.string    'REM',       limit: 64
    t.timestamp 't', null: false
    t.string    'GenExtSig', limit: 3, default: "да", null: false
    t.index ['Project'], name: 'Project'
    t.index %w(ped Project), name: 'ped', unique: true
    t.index ['ped_N'], name: 'ped_N', unique: true
    t.index ['type'], name: 'type'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'hw_peds_ibfk_1'
    t.foreign_key ['type'], 'hw_devtype', ['typeID'], on_update: :restrict, on_delete: :restrict, name: 'hw_peds_ibfk_3'
  end

  create_table 'pds_panel', primary_key: 'pID', force: true do |t|
    t.string  'panel',           limit: 32
    t.string  'start',           limit: 15
    t.string  'end',             limit: 15
    t.integer 'migsjem'
    t.integer 'memsjem'
    t.integer 'lamptest'
    t.integer 'soundtest'
    t.integer 'soundtest_warn'
    t.integer 'pressconfirm'
    t.integer 'soundtest_alarm'
    t.integer 'Project', null: false
    t.integer 'soundsjem'
    t.integer 'soundalarm'
    t.string  'power_lamp', limit: 63
    t.integer 'Tab_No'
    t.string  'pnl_type',        limit: 3
    t.string  'fhd',             limit: 16, default: 'fhd'
    t.string  'lamptest_suff',   limit: 16
    t.integer 'lo_cnt'
    t.index ['Project'], name: 'Project'
    t.index ['lamptest'], name: 'lamptest'
    t.index ['memsjem'], name: 'memsjem'
    t.index ['migsjem'], name: 'migsjem'
    t.index ['pID'], name: 'pID', unique: true
    t.index ['pressconfirm'], name: 'pressconfirm'
    t.index ['soundsjem'], name: 'soundsjem'
    t.index ['soundtest'], name: 'soundtest'
    t.index ['soundtest_alarm'], name: 'soundtest_alarm'
    t.index ['soundtest_warn'], name: 'soundtest_warn'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_panel_ibfk_8'
  end

  create_table 'hw_ic', primary_key: 'icID', force: true do |t|
    t.integer   'Project', null: false
    t.string    'ref', limit: 128
    t.integer   'ped'
    t.string    'rev',            limit: 1
    t.string    'tag_no',         limit: 330
    t.string    'UniquePTAG',     limit: 330
    t.string    'un',             limit: 2
    t.string    'bv',             limit: 11
    t.string    'panel',          limit: 32
    t.string    'coord',          limit: 6
    t.float     'scaleMin',       limit: 53
    t.float     'scaleMax',       limit: 53
    t.integer   'Unit'
    t.string    'Description', limit: 1000
    t.timestamp 't', null: false
    t.string    'Type', limit: 1
    t.integer   'sys'
    t.text      'Description_EN'
    t.integer   'panel_id'
    t.string    'suffix',         limit: 10
    t.integer   'version',        limit: 1, default: 1
    t.string    'mark',           limit: 32
    t.index ['Project'], name: 'Project'
    t.index ['Unit'], name: 'Unit'
    t.index ['icID'], name: 'icID', unique: true
    t.index ['panel_id'], name: 'FK_hw_ic22'
    t.index ['ped'], name: 'ped_N'
    t.index ['ref'], name: 'ref'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'hw_ic_ibfk_8'
    t.foreign_key ['Unit'], 'pds_project_unit', ['ProjUnitID'], on_update: :cascade, on_delete: :restrict, name: 'hw_ic_ibfk_7'
    t.foreign_key ['panel_id'], 'pds_panel', ['pID'], on_update: :cascade, on_delete: :set_null, name: 'FK_hw_ic22'
    t.foreign_key ['ped'], 'hw_peds', ['ped_N'], on_update: :cascade, on_delete: :restrict, name: 'hw_ic_ibfk_6'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'hw_ic_ibfk_9'
  end

  add_foreign_key 'pds_panel', ['lamptest'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :set_null, name: 'pds_panel_ibfk_3'
  add_foreign_key 'pds_panel', ['memsjem'], 'hw_ic', ['icID'], on_update: :restrict, on_delete: :set_null, name: 'pds_panel_ibfk_9'
  add_foreign_key 'pds_panel', ['migsjem'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :set_null, name: 'pds_panel_ibfk_1'
  add_foreign_key 'pds_panel', ['pressconfirm'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :set_null, name: 'pds_panel_ibfk_6'
  add_foreign_key 'pds_panel', ['soundsjem'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :set_null, name: 'pds_panel_ibfk_10'
  add_foreign_key 'pds_panel', ['soundtest'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :set_null, name: 'pds_panel_ibfk_11'
  add_foreign_key 'pds_panel', ['soundtest_alarm'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :set_null, name: 'pds_panel_ibfk_7'
  add_foreign_key 'pds_panel', ['soundtest_warn'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :set_null, name: 'pds_panel_ibfk_4'

  create_view 'for_sapphire', '(select `dwg_panels`.`dp_id` AS `dp_id`,`dwg_panels`.`Project` AS `Project`,`dwg_panels`.`panel` AS `panel`,`dwg_panels`.`NAME` AS `NAME`,`dwg_panels`.`EV` AS `EV`,`dwg_panels`.`EH` AS `EH`,`dwg_panels`.`SV` AS `SV`,`dwg_panels`.`SH` AS `SH`,`dwg_panels`.`MP_CMEMO` AS `MP_CMEMO`,(case isnull(`hw_ic`.`tag_no`) when 1 then `dwg_panels`.`MP_CODE` else `hw_ic`.`tag_no` end) AS `MP_CODE`,`dwg_panels`.`MP_CODE1` AS `MP_CODE1`,`dwg_panels`.`MP_CODE2` AS `MP_CODE2`,`dwg_panels`.`MP_L0` AS `MP_L0`,`dwg_panels`.`MP_MASS` AS `MP_MASS`,`dwg_panels`.`MP_MAX` AS `MP_MAX`,`dwg_panels`.`MP_MIN` AS `MP_MIN`,`dwg_panels`.`MP_MODE` AS `MP_MODE`,`dwg_panels`.`MP_MODEORD` AS `MP_MODEORD`,`dwg_panels`.`MP_NAME0` AS `MP_NAME0`,`dwg_panels`.`MP_NAME1` AS `MP_NAME1`,`dwg_panels`.`MP_ORDER` AS `MP_ORDER`,`dwg_panels`.`MP_PROJ` AS `MP_PROJ`,`dwg_panels`.`MP_S0` AS `MP_S0`,`dwg_panels`.`MP_S100` AS `MP_S100`,`dwg_panels`.`MP_S20` AS `MP_S20`,`dwg_panels`.`MP_S40` AS `MP_S40`,`dwg_panels`.`MP_S50` AS `MP_S50`,`dwg_panels`.`MP_S60` AS `MP_S60`,`dwg_panels`.`MP_S80` AS `MP_S80`,(case isnull(`hw_ic`.`icID`) when 1 then `dwg_panels`.`MP_TYPE0` else `hw_peds`.`ped` end) AS `MP_TYPE0`,`dwg_panels`.`MP_TYPE1` AS `MP_TYPE1`,`dwg_panels`.`MP_U0` AS `MP_U0`,`dwg_panels`.`MP_U1` AS `MP_U1`,`dwg_panels`.`MP_IO` AS `MP_IO`,`dwg_panels`.`MP_IOCONT` AS `MP_IOCONT`,`dwg_panels`.`MP_IONAME` AS `MP_IONAME`,`dwg_panels`.`TYPE` AS `TYPE`,`dwg_panels`.`FONT` AS `FONT`,`dwg_panels`.`MIRROR` AS `MIRROR`,`dwg_panels`.`ROTATE` AS `ROTATE`,`dwg_panels`.`revision` AS `revision`,`dwg_panels`.`t` AS `t`,`dwg_panels`.`rotation` AS `rotation`,`dwg_panels`.`ref` AS `ref`,`dwg_panels`.`MP_L0_1` AS `MP_L0_1`,`dwg_panels`.`MP_L0_2` AS `MP_L0_2`,`dwg_panels`.`MP_L0_3` AS `MP_L0_3`,`dwg_panels`.`MP_L0_4` AS `MP_L0_4`,`dwg_panels`.`MP_L0_0_x` AS `MP_L0_0_x`,`dwg_panels`.`MP_L0_0_y` AS `MP_L0_0_y`,`dwg_panels`.`MP_L0_0_w` AS `MP_L0_0_w`,`dwg_panels`.`MP_L0_0_h` AS `MP_L0_0_h`,`dwg_panels`.`MP_L0_0_f` AS `MP_L0_0_f`,`dwg_panels`.`MP_L0_1_x` AS `MP_L0_1_x`,`dwg_panels`.`MP_L0_1_y` AS `MP_L0_1_y`,`dwg_panels`.`MP_L0_1_w` AS `MP_L0_1_w`,`dwg_panels`.`MP_L0_1_h` AS `MP_L0_1_h`,`dwg_panels`.`MP_L0_1_f` AS `MP_L0_1_f`,`dwg_panels`.`MP_L0_2_x` AS `MP_L0_2_x`,`dwg_panels`.`MP_L0_2_y` AS `MP_L0_2_y`,`dwg_panels`.`MP_L0_2_w` AS `MP_L0_2_w`,`dwg_panels`.`MP_L0_2_h` AS `MP_L0_2_h`,`dwg_panels`.`MP_L0_2_f` AS `MP_L0_2_f`,`dwg_panels`.`MP_L0_3_x` AS `MP_L0_3_x`,`dwg_panels`.`MP_L0_3_y` AS `MP_L0_3_y`,`dwg_panels`.`MP_L0_3_w` AS `MP_L0_3_w`,`dwg_panels`.`MP_L0_3_h` AS `MP_L0_3_h`,`dwg_panels`.`MP_L0_3_f` AS `MP_L0_3_f`,`dwg_panels`.`MP_L0_4_x` AS `MP_L0_4_x`,`dwg_panels`.`MP_L0_4_y` AS `MP_L0_4_y`,`dwg_panels`.`MP_L0_4_w` AS `MP_L0_4_w`,`dwg_panels`.`MP_L0_4_h` AS `MP_L0_4_h`,`dwg_panels`.`MP_L0_4_f` AS `MP_L0_4_f` from ((`dwg_panels` left join `hw_ic` on(((convert(`dwg_panels`.`ref` using utf8) = `hw_ic`.`ref`) and (`dwg_panels`.`Project` = `hw_ic`.`Project`)))) left join `hw_peds` on((`hw_ic`.`ped` = `hw_peds`.`ped_N`))))', force: true
  create_table 'pds_alarm', primary_key: 'AlarmID', force: true do |t|
    t.integer   'IC',      null: false
    t.integer   'sys'
    t.integer   'Project', null: false
    t.timestamp 't',       null: false
    t.index ['AlarmID'], name: 'AlarmID', unique: true
    t.index ['IC'], name: 'IC'
    t.index ['Project'], name: 'Project'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_alarm_ibfk_4'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_alarm_ibfk_5'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :cascade, on_delete: :restrict, name: 'pds_alarm_ibfk_6'
  end

  create_table 'pds_announciator', primary_key: 'AnnouncID', force: true do |t|
    t.integer   'IC'
    t.integer   'Project', null: false
    t.integer   'sys'
    t.integer   'ctrl_power'
    t.timestamp 't', null: false
    t.string    'Type',            limit: 2
    t.string    'Gr_Dreg',         limit: 50
    t.integer   'Detector'
    t.string    'Characteristics', limit: 50
    t.string    'sign',            limit: 8
    t.string    'Code',            limit: 50
    t.index ['AnnouncID'], name: 'AnnouncID', unique: true
    t.index ['Detector'], name: 'Detector'
    t.index ['IC'], name: 'IC'
    t.index ['Project'], name: 'Project'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Detector'], 'pds_detectors', ['DetID'], on_update: :cascade, on_delete: :set_null, name: 'pds_announciator_ibfk_23'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_announciator_ibfk_20'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_announciator_ibfk_19'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_announciator_ibfk_21'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :cascade, on_delete: :restrict, name: 'pds_announciator_ibfk_22'
  end

  create_table 'pds_bru', primary_key: 'BRUID', force: true do |t|
    t.integer   'IC', null: false
    t.integer   'sys'
    t.integer   'Project',    null: false
    t.timestamp 't',          null: false
    t.integer   'ctrl_power'
    t.index ['BRUID'], name: 'BRUID', unique: true
    t.index ['IC'], name: 'IC'
    t.index ['Project'], name: 'Project'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_bru_ibfk_5'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_bru_ibfk_6'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_bru_ibfk_7'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_bru_ibfk_4'
  end

  create_table 'pds_buttons', primary_key: 'ButtonID', force: true do |t|
    t.integer   'IC', null: false
    t.integer   'sys'
    t.integer   'Project', null: false
    t.text      'range', limit: 16_777_215
    t.boolean   'Fixed', default: false
    t.timestamp 't', null: false
    t.index ['ButtonID'], name: 'ButtonID', unique: true
    t.index ['IC'], name: 'IC'
    t.index ['Project'], name: 'Project'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_buttons_ibfk_4'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_buttons_ibfk_5'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_buttons_ibfk_3'
  end

  create_table 'pds_lamps', primary_key: 'LampID', force: true do |t|
    t.integer   'IC'
    t.integer   'sys'
    t.integer   'Project', null: false
    t.integer   'ctrl_power'
    t.timestamp 't', null: false
    t.index ['IC'], name: 'IC'
    t.index ['LampID'], name: 'LampID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_lamps_ibfk_23'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_lamps_ibfk_24'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_lamps_ibfk_22'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_lamps_ibfk_21'
  end

  create_table 'pds_meters', primary_key: 'MetID', force: true do |t|
    t.integer   'IC', null: false
    t.integer   'sys'
    t.integer   'Project', null: false
    t.integer   'ctrl_power'
    t.timestamp 't', null: false
    t.index ['IC'], name: 'IC'
    t.index ['MetID'], name: 'MetID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_meters_ibfk_20'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_meters_ibfk_22'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_meters_ibfk_21'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_meters_ibfk_19'
  end

  create_table 'pds_meters_channels', primary_key: 'MetChanID', force: true do |t|
    t.integer   'IC',         null: false
    t.integer   'sys'
    t.integer   'Project', null: false
    t.integer   'ctrl_power'
    t.timestamp 't', null: false
    t.index ['IC'], name: 'IC'
    t.index ['MetChanID'], name: 'MetChanID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_meters_channels_ibfk_6'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_meters_channels_ibfk_7'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :restrict, name: 'pds_meters_channels_ibfk_8'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_meters_channels_ibfk_5'
  end

  create_table 'pds_meters_digital', primary_key: 'MetDigID', force: true do |t|
    t.integer   'IC', null: false
    t.integer   'sys'
    t.integer   'Project', null: false
    t.integer   'ctrl_power'
    t.timestamp 't', null: false
    t.index ['IC'], name: 'IC'
    t.index ['MetDigID'], name: 'MetDigID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_meters_digital_ibfk_6'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_meters_digital_ibfk_7'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_meters_digital_ibfk_8'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_meters_digital_ibfk_5'
  end

  create_table 'pds_misc', primary_key: 'MiscID', force: true do |t|
    t.integer   'IC', null: false
    t.integer   'sys'
    t.integer   'Project', null: false
    t.integer   'ctrl_power'
    t.timestamp 't', null: false
    t.index ['IC'], name: 'IC'
    t.index ['MiscID'], name: 'MiscID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_misc_ibfk_6'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_misc_ibfk_7'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_misc_ibfk_8'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_misc_ibfk_5'
  end

  create_table 'pds_recorders', primary_key: 'RecID', force: true do |t|
    t.integer   'IC', null: false
    t.integer   'sys'
    t.integer   'Project', null: false
    t.integer   'ctrl_power'
    t.timestamp 't', null: false
    t.index ['IC'], name: 'IC'
    t.index ['Project'], name: 'Project'
    t.index ['RecID'], name: 'RecID', unique: true
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_recorders_ibfk_5'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_recorders_ibfk_6'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_recorders_ibfk_7'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_recorders_ibfk_4'
  end

  create_table 'pds_set', primary_key: 'SetID', force: true do |t|
    t.integer   'IC',      null: false
    t.integer   'sys'
    t.integer   'Project', null: false
    t.timestamp 't',       null: false
    t.index ['IC'], name: 'IC'
    t.index ['Project'], name: 'Project'
    t.index ['SetID'], name: 'SetID', unique: true
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_set_ibfk_5'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_set_ibfk_6'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_set_ibfk_4'
  end

  create_table 'pds_switch_fix', primary_key: 'KeyID', force: true do |t|
    t.integer   'Project', null: false
    t.integer   'IC'
    t.integer   'sys'
    t.text      'range', limit: 16_777_215
    t.timestamp 't', null: false
    t.index ['IC'], name: 'IC'
    t.index ['KeyID'], name: 'KeyID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_switch_fix_ibfk_18'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_switch_fix_ibfk_17'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_switch_fix_ibfk_16'
  end

  create_table 'pds_switch_nofix', primary_key: 'KeyID', force: true do |t|
    t.integer   'Project', null: false
    t.integer   'IC'
    t.integer   'sys'
    t.text      'range', limit: 16_777_215
    t.timestamp 't', null: false
    t.index ['IC'], name: 'IC'
    t.index ['KeyID'], name: 'KeyID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_switch_nofix_ibfk_5'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_switch_nofix_ibfk_4'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_switch_nofix_ibfk_3'
  end

  create_view 'hw_ic_sys', 'select `pds_bru`.`sys` AS `sys`,`pds_bru`.`IC` AS `IC` from `pds_bru` union select `pds_misc`.`sys` AS `sys`,`pds_misc`.`IC` AS `IC` from `pds_misc` union select `pds_set`.`sys` AS `sys`,`pds_set`.`IC` AS `IC` from `pds_set` union select `pds_switch_fix`.`sys` AS `sys`,`pds_switch_fix`.`IC` AS `IC` from `pds_switch_fix` union select `pds_switch_nofix`.`sys` AS `sys`,`pds_switch_nofix`.`IC` AS `IC` from `pds_switch_nofix` union select `pds_buttons`.`sys` AS `sys`,`pds_buttons`.`IC` AS `IC` from `pds_buttons` union select `pds_lamps`.`sys` AS `sys`,`pds_lamps`.`IC` AS `IC` from `pds_lamps` union select `pds_meters`.`sys` AS `sys`,`pds_meters`.`IC` AS `IC` from `pds_meters` union select `pds_meters_channels`.`sys` AS `sys`,`pds_meters_channels`.`IC` AS `IC` from `pds_meters_channels` union select `pds_meters_digital`.`sys` AS `sys`,`pds_meters_digital`.`IC` AS `IC` from `pds_meters_digital` union select `pds_recorders`.`sys` AS `sys`,`pds_recorders`.`IC` AS `IC` from `pds_recorders` union select `pds_announciator`.`sys` AS `sys`,`pds_announciator`.`IC` AS `IC` from `pds_announciator` union select `pds_alarm`.`sys` AS `sys`,`pds_alarm`.`IC` AS `IC` from `pds_alarm`', force: true
  create_table 'hw_ic_temp', primary_key: 'icID', force: true do |t|
    t.integer   'Project', null: false
    t.string    'ref', limit: 128
    t.integer   'ped'
    t.string    'rev',            limit: 1
    t.string    'tag_no',         limit: 330
    t.string    'UniquePTAG',     limit: 128
    t.string    'un',             limit: 2
    t.string    'bv',             limit: 11
    t.string    'panel',          limit: 32
    t.string    'coord',          limit: 6
    t.float     'scaleMin',       limit: 53
    t.float     'scaleMax',       limit: 53
    t.string    'UnitText',       limit: 32
    t.string    'Description',    limit: 1000
    t.timestamp 't', null: false
    t.string    'Type', limit: 1
    t.text      'Description_EN'
    t.integer   'version',        limit: 1, default: 1
    t.string    'suffix',         limit: 10
    t.integer   'Unit'
    t.string    'ic_r'
    t.string    'action', limit: 16
    t.index ['Project'], name: 'Project'
    t.index ['icID'], name: 'icID', unique: true
    t.index ['ped'], name: 'ped_N'
    t.index ['ref'], name: 'ref'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'hw_ict_ibfk_8'
    t.foreign_key ['ped'], 'hw_peds', ['ped_N'], on_update: :cascade, on_delete: :restrict, name: 'hw_ict_ibfk_6'
  end

  create_table 'hw_iosignaldef', primary_key: 'ID', force: true do |t|
    t.string 'ioname',  limit: 15,               null: false
    t.string 'memtype', limit: 2, default: '-'
    t.string 'rem',     limit: 30
    t.index ['ID'], name: 'ioID', unique: true
    t.index ['ioname'], name: 'ioname', unique: true
  end

  create_table 'hw_iosignal', primary_key: 'ID', force: true do |t|
    t.integer   'Project',                 null: false
    t.integer   'pedID',                   null: false
    t.integer   'signID',                  null: false
    t.integer   'wirecode'
    t.string    'contact',     limit: 16
    t.string    'sw_pref',     limit: 15
    t.string    'sw_suff',     limit: 15
    t.string    'hw_suff',     limit: 15
    t.string    'comment',     limit: 32
    t.integer   'contactnum',  limit: 2
    t.string    'description', limit: 64
    t.string    'diapason',    limit: 128
    t.string    'limits',      limit: 32
    t.timestamp 't', null: false
    t.integer   'temp'
    t.index ['ID'], name: 'ID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['pedID'], name: 'pedID'
    t.index ['signID'], name: 'signID'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'hw_iosignal_ibfk_1'
    t.foreign_key ['pedID'], 'hw_peds', ['ped_N'], on_update: :cascade, on_delete: :cascade, name: 'hw_iosignal_ibfk_4'
    t.foreign_key ['signID'], 'hw_iosignaldef', ['ID'], on_update: :restrict, on_delete: :restrict, name: 'hw_iosignal_ibfk_3'
  end

  create_table 'hw_iosignaldim', primary_key: 'ID', force: true do |t|
    t.integer 'Project',                            null: false
    t.integer 'signID',                             null: false
    t.integer 'num'
    t.string  'type',    limit: 3,  default: 'ALL', null: false
    t.string  'suff',    limit: 32, default: ''
    t.index ['Project'], name: 'FK_hw_iosignaldim1'
    t.index %w(signID num type Project), name: 'signID', unique: true
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :cascade, name: 'FK_hw_iosignaldim1'
    t.foreign_key ['signID'], 'hw_iosignal', ['ID'], on_update: :cascade, on_delete: :cascade, name: 'FK_hw_iosignaldim2'
  end

  create_table 'hw_peds_copy', primary_key: 'ped_N', force: true do |t|
    t.integer   'ped_NNN'
    t.integer   'ped_NN'
    t.integer   'Project',                             null: false
    t.string    'ped',       limit: 32, default: '',   null: false
    t.string    'Code',      limit: 50
    t.integer   'AI',                   default: 0
    t.integer   'AO',                   default: 0
    t.integer   'AO*',                  default: 0
    t.integer   'DI',                   default: 0
    t.integer   'LO',                   default: 0
    t.integer   'LO*',                  default: 0
    t.integer   'LO+',                  default: 0
    t.integer   'LO220',                default: 0
    t.integer   'RO',                   default: 0
    t.integer   'DO',                   default: 0
    t.integer   'IOSUM'
    t.float     '5VDC',      limit: 53, default: 0.0
    t.float     '24VDC',     limit: 53, default: 0.0
    t.float     '10VDC',     limit: 53, default: 0.0
    t.float     '12VDC',     limit: 53, default: 0.0
    t.float     '60VDC',     limit: 53, default: 0.0
    t.float     '100VDC',    limit: 53, default: 0.0
    t.float     '9VDC',      limit: 53, default: 0.0
    t.float     '220VAC',    limit: 53, default: 0.0
    t.float     '1,2VAC',    limit: 53, default: 0.0
    t.float     '1,5VAC',    limit: 53, default: 0.0
    t.float     '2,5VAC',    limit: 53, default: 0.0
    t.float     '5VAC',      limit: 53, default: 0.0
    t.integer   'type'
    t.string    'VENDOR',    limit: 30
    t.string    'DESCRIPT',  limit: 64
    t.string    'REM',       limit: 64
    t.timestamp 't', null: false
    t.string    'GenExtSig', limit: 3, default: "да", null: false
    t.index ['ped_N'], name: 'ped_N', unique: true
    t.index ['type'], name: 'type'
  end

  create_table 'hw_wirelist', primary_key: 'wirelist_N', force: true do |t|
    t.string    'from'
    t.string    'to'
    t.string    'wc', limit: 11
    t.string    'nc'
    t.string    'io', limit: 4
    t.integer   'm'
    t.integer   's'
    t.integer   'word'
    t.string    'bit'
    t.string    'power'
    t.string    'origin'
    t.string    'net'
    t.integer   'ped'
    t.integer   'Project', null: false
    t.string    'rev'
    t.integer   'Unit'
    t.integer   'step', default: 0
    t.timestamp 't', null: false
    t.integer   'IC'
    t.string    'remarks'
    t.integer   'io_signalID'
    t.string    'panel',       limit: 32
    t.string    'pds_mark',    limit: 8
    t.index ['IC'], name: 'IC'
    t.index ['Project'], name: 'Project'
    t.index ['Unit'], name: 'Unit'
    t.index ['io_signalID'], name: 'io_signalID'
    t.index ['ped'], name: 'ped_N'
    t.index ['wirelist_N'], name: 'wirelist_N', unique: true
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :set_null, name: 'hw_wirelist_ibfk_6'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'hw_wirelist_ibfk_5'
    t.foreign_key ['Unit'], 'pds_project_unit', ['ProjUnitID'], on_update: :cascade, on_delete: :restrict, name: 'hw_wirelist_ibfk_4'
    t.foreign_key ['io_signalID'], 'hw_iosignal', ['ID'], on_update: :cascade, on_delete: :set_null, name: 'hw_wirelist_ibfk_7'
    t.foreign_key ['ped'], 'hw_peds', ['ped_N'], on_update: :cascade, on_delete: :restrict, name: 'hw_wirelist_ibfk_3'
  end

  create_table 'lettrs_adressat', primary_key: 'adressatID', force: true do |t|
    t.string 'Name',        limit: 30
    t.string 'ShortAdress', limit: 30
    t.string 'Adress',      limit: 100
    t.string 'JobTitle',    limit: 30
    t.index ['ShortAdress'], name: 'ShortAdress'
    t.index ['adressatID'], name: 'adressatID', unique: true
  end

  create_table 'input_letters', primary_key: 'InputLettersID', force: true do |t|
    t.date      'Date'
    t.integer   'To'
    t.integer   'From'
    t.string    'Number', limit: 30
    t.integer   'BlobObj'
    t.timestamp 't', null: false
    t.index ['BlobObj'], name: 'BlobObj'
    t.index ['From'], name: 'From'
    t.index ['InputLettersID'], name: 'InputLetersID', unique: true
    t.index ['To'], name: 'To'
    t.foreign_key ['BlobObj'], 'tblbinaries', ['ObjectID'], on_update: :restrict, on_delete: :restrict, name: 'input_letters_ibfk_3'
    t.foreign_key ['From'], 'pds_engineers', ['engineer_N'], on_update: :restrict, on_delete: :set_null, name: 'input_letters_ibfk_1'
    t.foreign_key ['To'], 'lettrs_adressat', ['adressatID'], on_update: :restrict, on_delete: :restrict, name: 'input_letters_ibfk_2'
  end

  create_table 'news', primary_key: 'newsID', force: true do |t|
    t.text      'news'
    t.timestamp 't', null: false
    t.date      'date'
    t.index ['newsID'], name: 'newsID', unique: true
  end

  create_view 'panels_revisions', '(select max(`dwg_panels`.`revision`) AS `max_revision`,`dwg_panels`.`NAME` AS `NAME`,`dwg_panels`.`Project` AS `Project` from `dwg_panels` group by `dwg_panels`.`Project`,`dwg_panels`.`NAME`)', force: true
  create_table 'pds_air_valves', primary_key: 'AvalvesID', force: true do |t|
    t.integer 'sys'
    t.integer 'Project', null: false
    t.string  'tag', limit: 10
    t.string  'Description'
    t.string  'Description_EN'
    t.integer 'Open'
    t.integer 'Close'
    t.integer 'ctrl_power'
    t.integer 'Air_power'
    t.index ['AvalvesID'], name: 'AvalvesID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_air_valves_ibfk_5'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :restrict, name: 'pds_air_valves_ibfk_6'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_air_valves_ibfk_4'
  end

  create_table 'pds_alg_type', primary_key: 'algID', force: true do |t|
    t.integer 'Project',             null: false
    t.string  'alg_type', limit: 16, null: false
    t.integer 'numb'
  end

  create_table 'pds_algorithms', primary_key: 'AlgoID', force: true do |t|
    t.string  'Name', null: false
    t.binary  'Data', limit: 16_777_215
    t.integer 'sys', null: false
    t.index ['AlgoID'], name: 'AlgoID', unique: true
    t.index ['sys'], name: 'sys'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_algorithms_ibfk_1'
  end

  create_table 'pds_algo_inputs', primary_key: 'InptID', force: true do |t|
    t.integer 'Algorithm',      null: false
    t.string  'Name',           null: false
    t.string  'Description'
    t.string  'Description_EN'
    t.string  'varname', null: false
    t.integer 'Type'
    t.integer 'Unit'
    t.index ['Algorithm'], name: 'Algorithm'
    t.index ['InptID'], name: 'InptID', unique: true
    t.index ['Unit'], name: 'Unit'
    t.foreign_key ['Algorithm'], 'pds_algorithms', ['AlgoID'], on_update: :cascade, on_delete: :cascade, name: 'pds_algo_inputs_ibfk_1'
    t.foreign_key ['Unit'], 'pds_project_unit', ['ProjUnitID'], on_update: :restrict, on_delete: :restrict, name: 'pds_algo_inputs_ibfk_2'
  end

  create_table 'pds_algo_outs', primary_key: 'OutID', force: true do |t|
    t.integer 'Algorithm',   null: false
    t.string  'Name',        null: false
    t.string  'Description'
    t.integer 'Unit'
    t.string  'varname', null: false
    t.index ['Algorithm'], name: 'Algorithm'
    t.index ['OutID'], name: 'OutID', unique: true
    t.index ['Unit'], name: 'Unit'
    t.foreign_key ['Algorithm'], 'pds_algorithms', ['AlgoID'], on_update: :cascade, on_delete: :cascade, name: 'pds_algo_outs_ibfk_1'
    t.foreign_key ['Unit'], 'pds_project_unit', ['ProjUnitID'], on_update: :restrict, on_delete: :restrict, name: 'pds_algo_outs_ibfk_2'
  end

  create_table 'pds_blocks', primary_key: 'blockID', force: true do |t|
    t.integer 'sys'
    t.string  'p_p', limit: 15
    t.text    'Desc'
    t.integer 'doc'
    t.string  'varName', limit: 32
    t.integer 'Project', null: false
    t.index ['Project'], name: 'Project'
    t.index ['blockID'], name: 'blockID', unique: true
    t.index ['doc'], name: 'doc'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_blocks_ibfk_3'
    t.foreign_key ['doc'], 'pds_documentation', ['DocID'], on_update: :cascade, on_delete: :restrict, name: 'pds_blocks_ibfk_2'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :cascade, on_delete: :restrict, name: 'pds_blocks_ibfk_1'
  end

  create_table 'pds_blocks_systems', primary_key: 'ID', force: true do |t|
    t.integer 'block', null: false
    t.integer 'sys',   null: false
    t.index ['ID'], name: 'ID', unique: true
    t.index ['block'], name: 'block'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['block'], 'pds_blocks', ['blockID'], on_update: :cascade, on_delete: :cascade, name: 'pds_blocks_systems_ibfk_3'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :cascade, on_delete: :no_action, name: 'pds_blocks_systems_ibfk_4'
  end

  create_view 'pds_breakers_60', 'select `pds_syslist`.`System` AS `System`,`pds_breakers`.`tag_RU` AS `tag_RU`,`pds_breakers`.`tag_EN` AS `tag_EN`,`pds_breakers`.`Desc_RU` AS `Desc_RU`,`pds_breakers`.`Desc_EN` AS `Desc_EN` from (`pds_breakers` left join `pds_syslist` on((`pds_breakers`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_breakers`.`Project` = 40000002)', force: true
  create_view 'pds_breakers_62', 'select `pds_syslist`.`System` AS `System`,`pds_breakers`.`tag_RU` AS `tag_RU`,`pds_breakers`.`tag_EN` AS `tag_EN`,`pds_breakers`.`Desc_RU` AS `Desc_RU`,`pds_breakers`.`Desc_EN` AS `Desc_EN` from (`pds_breakers` left join `pds_syslist` on((`pds_breakers`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_breakers`.`Project` = 200000001)', force: true
  create_view 'pds_breakers_73', 'select `pds_syslist`.`System` AS `System`,`pds_breakers`.`tag_RU` AS `tag_RU`,`pds_breakers`.`tag_EN` AS `tag_EN`,`pds_breakers`.`Desc_RU` AS `Desc_RU`,`pds_breakers`.`Desc_EN` AS `Desc_EN` from (`pds_breakers` left join `pds_syslist` on((`pds_breakers`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_breakers`.`Project` = 200000005)', force: true
  create_table 'pds_buttons_lights', primary_key: 'ButtonID', force: true do |t|
    t.integer   'IC', null: false
    t.integer   'sys'
    t.integer   'Project', null: false
    t.integer   'ctrl_power'
    t.text      'range', limit: 16_777_215
    t.boolean   'Fixed', default: false
    t.timestamp 't', null: false
    t.index ['ButtonID'], name: 'ButtonID', unique: true
    t.index ['IC'], name: 'IC'
    t.index ['Project'], name: 'Project'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['IC'], 'hw_ic', ['icID'], on_update: :cascade, on_delete: :cascade, name: 'pds_buttons_lights_ibfk_6'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_buttons_lights_ibfk_7'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :no_action, on_delete: :set_null, name: 'pds_buttons_lights_ibfk_8'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_buttons_lights_ibfk_5'
  end

  create_table 'pds_customers', primary_key: 'customerID', force: true do |t|
    t.integer   'Project', null: false
    t.string    'AgreeName', limit: 50, null: false
    t.timestamp 't', null: false
    t.string    'AgreeJobTitle',        limit: 50
    t.string    'AgreeJobTitle_EN',     limit: 50
    t.string    'AcceptedName1',        limit: 50
    t.string    'AcceptedJobTitle1',    limit: 50
    t.string    'AcceptedJobTitle1_EN', limit: 50
    t.string    'AcceptedName2',        limit: 50
    t.string    'AcceptedJobTitle2',    limit: 50
    t.string    'AcceptedJobTitle2_EN', limit: 50
    t.string    'Name',                 limit: 50
    t.index ['Project'], name: 'Project'
    t.index ['customerID'], name: 'customer_N', unique: true
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_customers_ibfk_1'
  end

  create_table 'pds_doc_on_sys', primary_key: 'DocSysID', force: true do |t|
    t.integer   'Doc', null: false
    t.integer   'sys'
    t.timestamp 't', null: false
    t.index ['Doc'], name: 'Doc'
    t.index ['DocSysID'], name: 'DocSysID', unique: true
    t.index ['sys'], name: 'Sys'
    t.foreign_key ['Doc'], 'pds_documentation', ['DocID'], on_update: :cascade, on_delete: :cascade, name: 'pds_doc_on_sys_ibfk_5'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_doc_on_sys_ibfk_4'
  end

  create_table 'pds_documents', primary_key: 'docID', force: true do |t|
    t.string    'DocTitle', null: false
    t.string    'Code', limit: 63
    t.integer   'Author'
    t.integer   'Project', null: false
    t.string    'FileRu'
    t.string    'FileEn'
    t.integer   'CheckOutRu'
    t.timestamp 't', null: false
    t.integer   'CheckOutEn'
    t.index ['Author'], name: 'Author'
    t.index ['CheckOutEn'], name: 'CheckOutEn'
    t.index ['CheckOutRu'], name: 'CheckOut'
    t.index ['Project'], name: 'Project'
    t.index ['docID'], name: 'docID', unique: true
    t.foreign_key ['Author'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :no_action, name: 'pds_documents_ibfk_1'
    t.foreign_key ['CheckOutEn'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_documents_ibfk_4'
    t.foreign_key ['CheckOutRu'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_documents_ibfk_5'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :no_action, name: 'pds_documents_ibfk_2'
  end

  create_table 'pds_dr_binobj', primary_key: 'objID', force: true do |t|
    t.integer   'Project', null: false
    t.string    'Title'
    t.binary    'BinObj', limit: 16_777_215
    t.integer   'drID', null: false
    t.string    'Type', limit: 16
    t.integer   'Length'
    t.timestamp 't'
  end

  create_table 'pds_dr_stats', primary_key: 'hist_id', force: true do |t|
    t.integer   'Project',                 null: false
    t.integer   'sys_id',                  null: false
    t.integer   'opened',      default: 0, null: false
    t.integer   'closed',      default: 0, null: false
    t.integer   'in_progress', default: 0, null: false
    t.integer   'rfr',         default: 0, null: false
    t.integer   'overdue'
    t.timestamp 'date_stamp', null: false
    t.index ['Project'], name: 'FK_pds_dr_stats'
    t.index ['sys_id'], name: 'FK_pds_dr_stats_sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :restrict, on_delete: :restrict, name: 'FK_pds_dr_stats1'
    t.foreign_key ['sys_id'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'FK_pds_dr_stats_sys1'
  end

  create_table 'pds_ejector', primary_key: 'ejectorID', force: true do |t|
    t.string  'kks',       limit: 15, null: false
    t.string  'ShortDesc', limit: 80
    t.text    'Desc_EN'
    t.float   'capacity',  limit: 24
    t.float   'level',     limit: 24
    t.string  'room',      limit: 15
    t.integer 'Project', null: false
    t.integer 'sys'
    t.integer 'eq_type'
    t.integer 'Unit'
    t.integer 'sd_N'
    t.index ['Project'], name: 'FK_pds_ejector1'
    t.index ['Unit'], name: 'FK_pds_ejector_unit1'
    t.index ['eq_type'], name: 'FK_pds_ejector_eq_type1'
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'FK_pds_ejector_sys1'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :cascade, name: 'FK_pds_ejector1'
    t.foreign_key ['Unit'], 'pds_project_unit', ['ProjUnitID'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_ejector_unit1'
    t.foreign_key ['eq_type'], 'pds_man_equip', ['EquipN'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_ejector_eq_type1'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :restrict, name: 'FK_pds_ejector_sd_N'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :cascade, on_delete: :cascade, name: 'FK_pds_ejector_sys1'
  end

  create_table 'pds_eng_on_sys', primary_key: 'AssignID', force: true do |t|
    t.integer   'sys',            null: false
    t.integer   'Project',        null: false
    t.integer   'engineer_N',     null: false
    t.timestamp 't',              null: false
    t.integer   'TestOperator_N'
    t.index ['AssignID'], name: 'AssignID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['TestOperator_N'], name: 'TestOperator_N'
    t.index ['engineer_N'], name: 'engineer_N'
    t.index ['sys'], name: 'System'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_eng_on_sys_ibfk_8'
    t.foreign_key ['TestOperator_N'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :restrict, name: 'pds_eng_on_sys_ibfk_7'
    t.foreign_key ['engineer_N'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :restrict, name: 'pds_eng_on_sys_ibfk_6'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_eng_on_sys_ibfk_4'
  end

  create_table 'pds_equips', primary_key: 'TEquipID', force: true do |t|
    t.string 'typeE', limit: 50, null: false
    t.index ['TEquipID'], name: 'TEquipID', unique: true
  end

  create_table 'pds_equipments', primary_key: 'EqID', force: true do |t|
    t.integer 'Project', null: false
    t.integer 'sys'
    t.string  'KKS', limit: 32
    t.integer 'eq_type'
    t.string  'Description_RU', limit: 100
    t.string  'Description_EN', limit: 100
    t.integer 'type_equip', null: false
    t.integer 'sd_N'
    t.index ['EqID'], name: 'EqID', unique: true
    t.index ['Project'], name: 'FK_pds_equipments1'
    t.index ['eq_type'], name: 'fk_eq_type'
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'fk_sys'
    t.index ['type_equip'], name: 'fk_type'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :cascade, name: 'FK_pds_equipments1'
    t.foreign_key ['eq_type'], 'pds_man_equip', ['EquipN'], on_update: :cascade, on_delete: :restrict, name: 'FK_pds_equipments_eq_type1'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :restrict, name: 'FK_pds_equipments_sd_N'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :cascade, on_delete: :cascade, name: 'FK_pds_equipments_sys1'
    t.foreign_key ['type_equip'], 'pds_equips', ['TEquipID'], on_update: :cascade, on_delete: :restrict, name: 'FK_pds_equipments_type'
  end

  create_table 'pds_sids', primary_key: 'sid_N', force: true do |t|
    t.integer   'Project', null: false
    t.string    'sid', limit: 15, null: false
    t.integer   'trainer_code'
    t.timestamp 't', null: false
    t.index ['Project'], name: 'Project'
    t.index ['sid'], name: 'sid', unique: true
    t.index ['sid_N'], name: 'sid_N', unique: true
    t.index ['trainer_code'], name: 'trainer_code_N'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_sids_ibfk_9'
  end

  create_table 'pds_iomap', primary_key: 'hwaddress_N', force: true do |t|
    t.integer   'Project',                         null: false
    t.string    'hwaddress',            limit: 20, null: false
    t.string    'io_point_name',        limit: 15
    t.integer   'number_of_array_elem'
    t.integer   'sid'
    t.string    'comp_name',            limit: 20
    t.string    'remark',               limit: 20
    t.timestamp 't', null: false
    t.index ['Project'], name: 'Project'
    t.index ['hwaddress'], name: 'hwaddress', unique: true
    t.index ['hwaddress_N'], name: 'hwaddress_N', unique: true
    t.index ['sid'], name: 'sid_N'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_iomap_ibfk_2'
    t.foreign_key ['sid'], 'pds_sids', ['sid_N'], on_update: :cascade, on_delete: :restrict, name: 'pds_iomap_ibfk_1'
  end

  create_table 'pds_malfunction', primary_key: 'MalfID', force: true do |t|
    t.integer   'sys',                                                 null: false
    t.integer   'Dimension', limit: 2, default: 1, null: false
    t.integer   'Project', null: false
    t.integer   'Numb', limit: 2, null: false
    t.text      'shortDesc', null: false
    t.text      'shortDesc_EN'
    t.text      'cause', null: false
    t.text      'cause_EN'
    t.text      'fullDesc',         limit: 16_777_215, null: false
    t.text      'fullDesc_EN',      limit: 16_777_215
    t.string    'type',             limit: 3, default: ''
    t.text      'if_delete',        limit: 16_777_215
    t.string    'if_delete_EN'
    t.float     'lowlim_regidity',  limit: 53
    t.float     'uplim_regidity',   limit: 53
    t.string    'regidity_unit',    limit: 5, default: 'dmnls'
    t.string    'regidity_text'
    t.string    'regidity_text_EN'
    t.string    'Unit_status'
    t.timestamp 't', null: false
    t.string    'File'
    t.integer   'regidity_unitid'
    t.integer   'scale', limit: 1
    t.integer   'sd_N'
    t.index ['File'], name: 'BlobObj'
    t.index ['MalfID'], name: 'MalfID', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['regidity_unitid'], name: 'regidity_unitid'
    t.index ['sd_N'], name: 'FK_pds_malfunction'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_malfunction_ibfk_2'
    t.foreign_key ['regidity_unitid'], 'pds_project_unit', ['ProjUnitID'], on_update: :restrict, on_delete: :restrict, name: 'pds_malfunction_ibfk_3'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_malfunction'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_malfunction_ibfk_1'
  end

  create_table 'pds_malfunction_dim', primary_key: 'MalfunctDimID', force: true do |t|
    t.integer 'Project',                                null: false
    t.integer 'Malfunction',                            null: false
    t.string  'Character', limit: 15
    t.string  'Target_EN'
    t.string  'Target'
    t.integer 'sd_N'
    t.boolean 'is_main', default: false
    t.index ['MalfunctDimID'], name: 'MalfunctDimID', unique: true
    t.index ['Malfunction'], name: 'Malfunction'
    t.index ['Project'], name: 'Project'
    t.index ['sd_N'], name: 'sd_N'
    t.foreign_key ['Malfunction'], 'pds_malfunction', ['MalfID'], on_update: :cascade, on_delete: :cascade, name: 'pds_malfunction_dim_ibfk_7'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_malfunction_dim_ibfk_4'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :restrict, name: 'pds_malfunction_dim_ibfk_6'
  end

  create_table 'pds_mathmodel', primary_key: 'mm_id', force: true do |t|
    t.integer 'Project', null: false
    t.integer 'sys'
    t.integer 'task_N'
    t.text    'Desc_RU'
    t.text    'Desc_EN'
    t.index ['Project'], name: 'FK_pds_mathmodel_prj'
    t.index ['sys'], name: 'FK_pds_mathmodel_sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :restrict, on_delete: :cascade, name: 'FK_pds_mathmodel_prj'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :cascade, name: 'FK_pds_mathmodel_sys'
  end

  create_table 'pds_mnemo', primary_key: 'MnemoID', force: true do |t|
    t.integer 'sys'
    t.integer 'Project',                      null: false
    t.string  'Code',            limit: 50,   null: false
    t.string  'Marker',          limit: 50
    t.string  'TechCode',        limit: 50
    t.string  'Type',            limit: 50
    t.string  'Opened',          limit: 50
    t.string  'Closed',          limit: 50
    t.string  'Control',         limit: 50
    t.string  'AutoDist',        limit: 50
    t.string  'Parameter',       limit: 50
    t.string  'Description',     limit: 1000
    t.string  'Description_EN'
    t.string  'Gr_Dreg', limit: 50
    t.integer 'Detector'
    t.string  'Characteristics', limit: 50
    t.index ['Detector'], name: 'Detector'
    t.index ['Project'], name: 'Project'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Detector'], 'pds_detectors', ['DetID'], on_update: :cascade, on_delete: :set_null, name: 'pds_mnemo_ibfk_5'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_mnemo_ibfk_4'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_mnemo_ibfk_3'
  end

  create_view 'pds_motors_59', '(select `pds_motors`.`t` AS `t`,`pds_motors`.`mod` AS `mod`,`pds_motors`.`import_t` AS `import_t`,`pds_motors`.`MotID` AS `MotID`,`pds_motors`.`model` AS `model`,`pds_motors`.`MotorType` AS `MotorTypeID`,`pds_motor_type`.`MotorType` AS `MotorType`,`pds_motors`.`up_rate` AS `up_rate`,`pds_motors`.`down_rate` AS `down_rate`,`pds_motors`.`sys` AS `SystemID`,`pds_syslist`.`System` AS `sys`,`pds_motors`.`station_sys` AS `station_sys`,`pds_motors`.`tag_RU` AS `tag_RU`,`pds_motors`.`tag_EN` AS `tag_EN`,`pds_motors`.`Desc_RU` AS `Desc_RU`,`pds_motors`.`Desc_EN` AS `Desc_EN`,`pds_motors`.`ed_power` AS `ed_powerID`,`pds_motors`.`type_temp` AS `type_temp`,`pds_motors`.`voltage` AS `voltage`,`pds_motors`.`RTZO_OLD1` AS `RTZO_OLD1`,`pds_motors`.`RTZO_OLD2` AS `RTZO_OLD2`,`pds_motors`.`RTZO_NEW1` AS `RTZO_NEW1`,`pds_motors`.`RTZO_NEW2` AS `RTZO_NEW2`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`ed_power`)) AS `ed_power`,`pds_motors`.`ctrl_power` AS `ctrl_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`ctrl_power`)) AS `ctrl_power`,`pds_motors`.`anc_power` AS `anc_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`anc_power`)) AS `anc_power`,`pds_motors`.`elevation` AS `elevation`,`pds_motors`.`Stopway` AS `Stopway`,`pds_motors`.`nom_state` AS `nom_state`,`pds_motors`.`lim_power` AS `lim_power`,`pds_motors`.`effeciency` AS `effeciency`,`pds_motors`.`rotation_speed` AS `rotation_speed`,`pds_motors`.`zmn` AS `zmn`,`pds_motors`.`sd_N` AS `sd`,`pds_motors`.`connection` AS `connection`,`pds_motors`.`i_nom` AS `i_nom`,`pds_motors`.`p_ust` AS `p_ust` from ((`pds_motors` left join `pds_motor_type` on((`pds_motors`.`MotorType` = `pds_motor_type`.`MotorTypeID`))) left join `pds_syslist` on((`pds_motors`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_motors`.`Project` = 40000001))', force: true
  create_view 'pds_motors_60', '(select `pds_motors`.`t` AS `t`,`pds_motors`.`mod` AS `mod`,`pds_motors`.`import_t` AS `import_t`,`pds_motors`.`MotID` AS `MotID`,`pds_motors`.`model` AS `model`,`pds_motors`.`MotorType` AS `MotorTypeID`,`pds_motor_type`.`MotorType` AS `MotorType`,`pds_motors`.`up_rate` AS `up_rate`,`pds_motors`.`down_rate` AS `down_rate`,`pds_motors`.`sys` AS `SystemID`,`pds_syslist`.`System` AS `sys`,`pds_motors`.`station_sys` AS `station_sys`,`pds_motors`.`tag_RU` AS `tag_RU`,`pds_motors`.`tag_EN` AS `tag_EN`,`pds_motors`.`Desc_RU` AS `Desc_RU`,`pds_motors`.`Desc_EN` AS `Desc_EN`,`pds_motors`.`ed_power` AS `ed_powerID`,`pds_motors`.`type_temp` AS `type_temp`,`pds_motors`.`voltage` AS `voltage`,`pds_motors`.`RTZO_OLD1` AS `RTZO_OLD1`,`pds_motors`.`RTZO_OLD2` AS `RTZO_OLD2`,`pds_motors`.`RTZO_NEW1` AS `RTZO_NEW1`,`pds_motors`.`RTZO_NEW2` AS `RTZO_NEW2`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`ed_power`)) AS `ed_power`,`pds_motors`.`ctrl_power` AS `ctrl_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`ctrl_power`)) AS `ctrl_power`,`pds_motors`.`anc_power` AS `anc_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`anc_power`)) AS `anc_power`,`pds_motors`.`elevation` AS `elevation`,`pds_motors`.`Stopway` AS `Stopway`,`pds_motors`.`nom_state` AS `nom_state`,`pds_motors`.`lim_power` AS `lim_power`,`pds_motors`.`effeciency` AS `effeciency`,`pds_motors`.`rotation_speed` AS `rotation_speed`,`pds_motors`.`zmn` AS `zmn`,`pds_motors`.`sd_N` AS `sd`,`pds_motors`.`connection` AS `connection`,`pds_motors`.`i_nom` AS `i_nom`,`pds_motors`.`p_ust` AS `p_ust`,(select `pds_man_equip`.`Type` AS `Type` from `pds_man_equip` where (`pds_man_equip`.`EquipN` = `pds_motors`.`eq_type`)) AS `eq_type` from ((`pds_motors` left join `pds_motor_type` on((`pds_motors`.`MotorType` = `pds_motor_type`.`MotorTypeID`))) left join `pds_syslist` on((`pds_motors`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_motors`.`Project` = 40000002))', force: true
  create_view 'pds_motors_62', '(select `pds_motors`.`t` AS `t`,`pds_motors`.`mod` AS `mod`,`pds_motors`.`import_t` AS `import_t`,`pds_motors`.`MotID` AS `MotID`,`pds_motors`.`model` AS `model`,`pds_motors`.`MotorType` AS `MotorTypeID`,`pds_motor_type`.`MotorType` AS `MotorType`,`pds_motors`.`up_rate` AS `up_rate`,`pds_motors`.`down_rate` AS `down_rate`,`pds_motors`.`sys` AS `SystemID`,`pds_syslist`.`System` AS `sys`,`pds_motors`.`station_sys` AS `station_sys`,`pds_motors`.`tag_RU` AS `tag_RU`,`pds_motors`.`tag_EN` AS `tag_EN`,`pds_motors`.`Desc_RU` AS `Desc_RU`,`pds_motors`.`Desc_EN` AS `Desc_EN`,`pds_motors`.`ed_power` AS `ed_powerID`,`pds_motors`.`type_temp` AS `type_temp`,`pds_motors`.`voltage` AS `voltage`,`pds_motors`.`RTZO_OLD1` AS `RTZO_OLD1`,`pds_motors`.`RTZO_OLD2` AS `RTZO_OLD2`,`pds_motors`.`RTZO_NEW1` AS `RTZO_NEW1`,`pds_motors`.`RTZO_NEW2` AS `RTZO_NEW2`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`ed_power`)) AS `ed_power`,`pds_motors`.`ctrl_power` AS `ctrl_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`ctrl_power`)) AS `ctrl_power`,`pds_motors`.`anc_power` AS `anc_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`anc_power`)) AS `anc_power`,`pds_motors`.`elevation` AS `elevation`,`pds_motors`.`Stopway` AS `Stopway`,`pds_motors`.`nom_state` AS `nom_state`,`pds_motors`.`lim_power` AS `lim_power`,`pds_motors`.`effeciency` AS `effeciency`,`pds_motors`.`rotation_speed` AS `rotation_speed`,`pds_motors`.`zmn` AS `zmn`,`pds_motors`.`sd_N` AS `sd`,`pds_motors`.`connection` AS `connection`,`pds_motors`.`i_nom` AS `i_nom`,`pds_motors`.`p_ust` AS `p_ust`,(select `pds_man_equip`.`Type` AS `Type` from `pds_man_equip` where (`pds_man_equip`.`EquipN` = `pds_motors`.`eq_type`)) AS `eq_type` from ((`pds_motors` left join `pds_motor_type` on((`pds_motors`.`MotorType` = `pds_motor_type`.`MotorTypeID`))) left join `pds_syslist` on((`pds_motors`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_motors`.`Project` = 200000001))', force: true
  create_view 'pds_motors_73', '(select `pds_motors`.`t` AS `t`,`pds_motors`.`mod` AS `mod`,`pds_motors`.`import_t` AS `import_t`,`pds_motors`.`MotID` AS `MotID`,`pds_motors`.`model` AS `model`,`pds_motors`.`MotorType` AS `MotorTypeID`,`pds_motor_type`.`MotorType` AS `MotorType`,`pds_motors`.`up_rate` AS `up_rate`,`pds_motors`.`down_rate` AS `down_rate`,`pds_motors`.`sys` AS `SystemID`,`pds_syslist`.`System` AS `sys`,`pds_motors`.`station_sys` AS `station_sys`,`pds_motors`.`tag_RU` AS `tag_RU`,`pds_motors`.`tag_EN` AS `tag_EN`,`pds_motors`.`Desc_RU` AS `Desc_RU`,`pds_motors`.`Desc_EN` AS `Desc_EN`,`pds_motors`.`ed_power` AS `ed_powerID`,`pds_motors`.`type_temp` AS `type_temp`,`pds_motors`.`voltage` AS `voltage`,`pds_motors`.`RTZO_OLD1` AS `RTZO_OLD1`,`pds_motors`.`RTZO_OLD2` AS `RTZO_OLD2`,`pds_motors`.`RTZO_NEW1` AS `RTZO_NEW1`,`pds_motors`.`RTZO_NEW2` AS `RTZO_NEW2`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`ed_power`)) AS `ed_power`,`pds_motors`.`ctrl_power` AS `ctrl_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`ctrl_power`)) AS `ctrl_power`,`pds_motors`.`anc_power` AS `anc_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_motors`.`anc_power`)) AS `anc_power`,`pds_motors`.`elevation` AS `elevation`,`pds_motors`.`Stopway` AS `Stopway`,`pds_motors`.`nom_state` AS `nom_state`,`pds_motors`.`lim_power` AS `lim_power`,`pds_motors`.`effeciency` AS `effeciency`,`pds_motors`.`rotation_speed` AS `rotation_speed`,`pds_motors`.`zmn` AS `zmn`,`pds_motors`.`sd_N` AS `sd`,`pds_motors`.`connection` AS `connection`,`pds_motors`.`i_nom` AS `i_nom`,`pds_motors`.`p_ust` AS `p_ust`,(select `pds_man_equip`.`Type` AS `Type` from `pds_man_equip` where (`pds_man_equip`.`EquipN` = `pds_motors`.`eq_type`)) AS `eq_type` from ((`pds_motors` left join `pds_motor_type` on((`pds_motors`.`MotorType` = `pds_motor_type`.`MotorTypeID`))) left join `pds_syslist` on((`pds_motors`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_motors`.`Project` = 200000005))', force: true
  create_table 'pds_negotiators', primary_key: 'nID', force: true do |t|
    t.string  'name',    limit: 128
    t.string  'post',    limit: 256
    t.integer 'Project', null: false
    t.boolean 'chef'
    t.integer 'ord'
  end

  create_table 'pds_ppca', primary_key: 'ppcID', force: true do |t|
    t.integer   'Project', null: false
    t.integer   'sys'
    t.string    'Shifr',          limit: 50
    t.string    'Key',            limit: 50
    t.string    'identif',        limit: 50
    t.text      'Description'
    t.text      'Description_EN'
    t.integer   'Detector'
    t.string    'Unit',           limit: 50
    t.float     'L_lim',          limit: 53
    t.float     'U_lim',          limit: 53
    t.string    'nom',            limit: 16
    t.float     'LA',             limit: 53
    t.float     'LW',             limit: 53
    t.float     'HW',             limit: 53
    t.float     'HA',             limit: 53
    t.timestamp 't', null: false
    t.string    'code'
    t.integer   'power', limit: 1, default: 0
    t.integer   'UnitID'
    t.index ['Detector'], name: 'detector'
    t.index ['Project'], name: 'ProjectID'
    t.index ['Shifr'], name: 'NewIndex1'
    t.index ['UnitID'], name: 'UnitID'
    t.index ['ppcID'], name: 'ppcID', unique: true
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Detector'], 'pds_detectors', ['DetID'], on_update: :restrict, on_delete: :restrict, name: 'pds_ppca_ibfk_5'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_ppca_ibfk_4'
    t.foreign_key ['UnitID'], 'pds_project_unit', ['ProjUnitID'], on_update: :restrict, on_delete: :restrict, name: 'pds_ppca_ibfk_6'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_ppca_ibfk_3'
  end

  create_table 'pds_ppcd', primary_key: 'ppcdID', force: true do |t|
    t.integer   'Project', null: false
    t.integer   'sys'
    t.string    'Shifr',          limit: 150
    t.string    'Key',            limit: 50
    t.string    'identif',        limit: 50
    t.text      'Description'
    t.text      'Description_EN'
    t.integer   'Detector'
    t.timestamp 't', null: false
    t.string    'code'
    t.index ['Detector'], name: 'detector'
    t.index ['Project'], name: 'Project'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Detector'], 'pds_detectors', ['DetID'], on_update: :restrict, on_delete: :restrict, name: 'pds_ppcd_ibfk_3'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :restrict, on_delete: :restrict, name: 'pds_ppcd_ibfk_1'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_ppcd_ibfk_2'
  end

  create_table 'pds_project_properties', primary_key: 'ProjectID', force: true do |t|
    t.string  'HostName',       limit: 32
    t.string  'HostIP',         limit: 32
    t.string  'SimDir',         limit: 63
    t.string  'ISName',         limit: 10
    t.string  'ISIP',           limit: 32
    t.string  'RootPass',       limit: 20
    t.string  'IOPass',         limit: 20
    t.string  'LoadPass',       limit: 20
    t.string  'TgisPass',       limit: 20
    t.string  'OSType',         limit: 13, default: 'Linux'
    t.integer 'LowLimKeyField'
    t.integer 'UpLimKeyField'
    t.string  'Language',       limit: 17
    t.string  'Enabled',        limit: 1, default: '1', null: false
    t.string  'ResName',        limit: 100
    t.string  'ClassLib',       limit: 64
    t.string  'ServicePort',    limit: 32
    t.integer 'StatsInterval',  limit: 1, default: 0, null: false
    t.string  'pdsCode',        limit: 64
    t.string  'fdsCode',        limit: 64
    t.string  'portS3serv',     limit: 32
    t.string  'report_prefix',  limit: 64
    t.string  'Encoding',       limit: 6
    t.string  'pmCode',         limit: 64
    t.string  'pmShortCode',    limit: 64
    t.string  'stCode',         limit: 64
    t.string  'stShortCode',    limit: 64
    t.index ['ProjectID'], name: 'ProjectID', unique: true
    t.foreign_key ['ProjectID'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :cascade, name: 'pds_project_properties_ibfk_1'
  end

  create_table 'pds_project_sys', primary_key: 'StationID', force: true do |t|
    t.integer   'Project',                null: false
    t.string    'Station_sys', limit: 15, null: false
    t.integer   'sys'
    t.string    'Desc_RU'
    t.string    'Desc_EN'
    t.timestamp 't', null: false
    t.index ['Project'], name: 'Project'
    t.index ['StationID'], name: 'StationID', unique: true
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_project_sys_ibfk_3'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_project_sys_ibfk_2'
  end

  create_table 'pds_queries', primary_key: 'queryID', force: true do |t|
    t.integer   'Project',                                         null: false
    t.integer   'sys',                                             null: false
    t.string    'queryNumber', limit: 15, null: false
    t.date      'query_make_date',                                 null: false
    t.date      'answer_expected_date',                            null: false
    t.text      'query_essence',                                   null: false
    t.integer   'engineer_N',                                      null: false
    t.date      'query_transfer_date'
    t.date      'answer_date'
    t.text      'answer_essence'
    t.string    'who_answered', limit: 50
    t.boolean   'if_close', default: false
    t.text      'Assumption'
    t.timestamp 't', null: false
    t.index ['Project'], name: 'Project'
    t.index ['engineer_N'], name: 'engineer_N'
    t.index ['sys'], name: 'sys'
    t.index ['who_answered'], name: 'who_answered'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_queries_ibfk_10'
    t.foreign_key ['engineer_N'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :restrict, name: 'pds_queries_ibfk_8'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_queries_ibfk_7'
  end

  create_table 'pds_regulators', primary_key: 'RegID', force: true do |t|
    t.string    'model', limit: 64
    t.integer   'Project', null: false
    t.integer   'sys'
    t.string    'tag_RU',      limit: 32
    t.string    'tag_EN',      limit: 32
    t.string    'station_sys', limit: 64
    t.string    'Desc',        limit: 100, null: false
    t.integer   'ed_power'
    t.integer   'ctrl_power'
    t.integer   'anc_power'
    t.float     'nom_state',   limit: 53
    t.float     'open_rate',   limit: 53
    t.float     'close_rate',  limit: 53
    t.integer   'sd_N'
    t.integer   'doc_reg_N'
    t.string    'Algorithm', limit: 64
    t.timestamp 't', null: false
    t.string    'Desc_EN', limit: 100, default: ''
    t.timestamp 'import_t'
    t.string    'mod'
    t.string    'vlv', limit: 127
    t.integer   'vlv_1'
    t.integer   'vlv_2'
    t.integer   'det_id'
    t.integer   'eq_type'
    t.float     'par_val',     limit: 53
    t.index ['Project'], name: 'Project'
    t.index ['RegID'], name: 'RegID', unique: true
    t.index ['anc_power'], name: 'anc_power'
    t.index ['ctrl_power'], name: 'ctrl_power'
    t.index ['det_id'], name: 'FK_pds_regulators_det_id'
    t.index ['doc_reg_N'], name: 'doc_reg_N'
    t.index ['ed_power'], name: 'ed_power'
    t.index ['eq_type'], name: 'FK_pds_regulators_eq_type'
    t.index ['sd_N'], name: 'sd_N'
    t.index ['sys'], name: 'sys'
    t.index ['vlv_1'], name: 'FK_pds_regulators'
    t.index ['vlv_2'], name: 'FK_pds_regulators_2'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_regulators_ibfk_30'
    t.foreign_key ['anc_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_regulators_ibfk_29'
    t.foreign_key ['ctrl_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_regulators_ibfk_28'
    t.foreign_key ['det_id'], 'pds_detectors', ['DetID'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_regulators_det_id'
    t.foreign_key ['doc_reg_N'], 'pds_documentation', ['DocID'], on_update: :cascade, on_delete: :restrict, name: 'pds_regulators_ibfk_25'
    t.foreign_key ['ed_power'], 'pds_section_assembler', ['section_N'], on_update: :cascade, on_delete: :set_null, name: 'pds_regulators_ibfk_27'
    t.foreign_key ['eq_type'], 'pds_man_equip', ['EquipN'], on_update: :cascade, on_delete: :set_null, name: 'FK_pds_regulators_eq_type'
    t.foreign_key ['sd_N'], 'pds_sd', ['sd_N'], on_update: :cascade, on_delete: :restrict, name: 'pds_regulators_ibfk_26'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_regulators_ibfk_24'
    t.foreign_key ['vlv_1'], 'pds_valves', ['valveID'], on_update: :cascade, on_delete: :restrict, name: 'FK_pds_regulators'
    t.foreign_key ['vlv_2'], 'pds_valves', ['valveID'], on_update: :cascade, on_delete: :restrict, name: 'FK_pds_regulators_2'
  end

  create_table 'pds_simplifications', primary_key: 'SimplID', force: true do |t|
    t.integer   'sys',                  null: false
    t.integer   'Project',              null: false
    t.string    'Numb', limit: 3, null: false
    t.text      'Desc',                 null: false
    t.text      'Desc_EN'
    t.text      'support', null: false
    t.text      'support_EN'
    t.integer   'queryID'
    t.timestamp 't', null: false
    t.index ['Project'], name: 'Project'
    t.index ['SimplID'], name: 'SimplID', unique: true
    t.index ['queryID'], name: 'query_N'
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_simplifications_ibfk_8'
    t.foreign_key ['queryID'], 'pds_queries', ['queryID'], on_update: :cascade, on_delete: :restrict, name: 'pds_simplifications_ibfk_7'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_simplifications_ibfk_6'
  end

  create_table 'pds_sys_description', primary_key: 'SysID', force: true do |t|
    t.integer 'Project',                           null: false
    t.integer 'sys',                               null: false
    t.text    'Description',    limit: 2_147_483_647
    t.text    'Description_EN', limit: 2_147_483_647
    t.text    'shortDesc'
    t.text    'shortDesc_EN'
    t.index %w(Project sys), name: 'Project_sys', unique: true
    t.index ['Project'], name: 'Project'
    t.index ['SysID'], name: 'SystemID', unique: true
    t.index ['sys'], name: 'System'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'pds_sys_description_ibfk_3'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'pds_sys_description_ibfk_2'
  end

  create_view 'pds_valves_59', '(select `pds_valves`.`t` AS `t`,`pds_valves`.`mod` AS `mod`,`pds_valves`.`import_t` AS `import_t`,`pds_valves`.`valveID` AS `valveID`,`pds_valves`.`sys` AS `SystemID`,`pds_syslist`.`System` AS `sys`,`pds_valves`.`tag_RU` AS `tag_RU`,`pds_valves`.`tag_EN` AS `tag_EN`,`pds_valves`.`Type` AS `Type`,`pds_valves`.`station_sys` AS `station_sys`,`pds_valves`.`Department` AS `Department`,`pds_valves`.`Desc` AS `Desc_RU`,`pds_valves`.`Desc_EN` AS `Desc_EN`,`pds_valves`.`PowerTemp` AS `PowerTemp`,`pds_valves`.`ed_power` AS `ed_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`ed_power`)) AS `ed_power`,`pds_valves`.`ctrl_power` AS `ctrl_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`ctrl_power`)) AS `ctrl_power`,`pds_valves`.`anc_power` AS `anc_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`anc_power`)) AS `anc_power`,`pds_valves`.`nom_state` AS `nom_state`,`pds_valves`.`open_rate` AS `open_rate`,`pds_valves`.`close_rate` AS `close_rate`,`pds_valves`.`Algorithm` AS `Algorithm`,`pds_valves`.`model` AS `model`,`pds_valves`.`connection` AS `connection` from (`pds_valves` left join `pds_syslist` on((`pds_valves`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_valves`.`Project` = 40000001))', force: true
  create_view 'pds_valves_60', '(select `pds_valves`.`t` AS `t`,`pds_valves`.`mod` AS `mod`,`pds_valves`.`import_t` AS `import_t`,`pds_valves`.`valveID` AS `valveID`,`pds_valves`.`sys` AS `SystemID`,`pds_syslist`.`System` AS `sys`,`pds_valves`.`tag_RU` AS `tag_RU`,`pds_valves`.`tag_EN` AS `tag_EN`,`pds_valves`.`Type` AS `Type`,`pds_valves`.`station_sys` AS `station_sys`,`pds_valves`.`Department` AS `Department`,`pds_valves`.`Desc` AS `Desc_RU`,`pds_valves`.`Desc_EN` AS `Desc_EN`,`pds_valves`.`PowerTemp` AS `PowerTemp`,`pds_valves`.`ed_power` AS `ed_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`ed_power`)) AS `ed_power`,`pds_valves`.`ctrl_power` AS `ctrl_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`ctrl_power`)) AS `ctrl_power`,`pds_valves`.`anc_power` AS `anc_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`anc_power`)) AS `anc_power`,`pds_valves`.`nom_state` AS `nom_state`,`pds_valves`.`open_rate` AS `open_rate`,`pds_valves`.`close_rate` AS `close_rate`,`pds_valves`.`Algorithm` AS `Algorithm`,`pds_valves`.`model` AS `model`,`pds_valves`.`connection` AS `connection`,(select `pds_man_equip`.`Type` AS `Type` from `pds_man_equip` where (`pds_man_equip`.`EquipN` = `pds_valves`.`eq_type`)) AS `eq_type` from (`pds_valves` left join `pds_syslist` on((`pds_valves`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_valves`.`Project` = 40000002))', force: true
  create_view 'pds_valves_62', '(select `pds_valves`.`t` AS `t`,`pds_valves`.`mod` AS `mod`,`pds_valves`.`import_t` AS `import_t`,`pds_valves`.`valveID` AS `valveID`,`pds_valves`.`sys` AS `SystemID`,`pds_syslist`.`System` AS `sys`,`pds_valves`.`tag_RU` AS `tag_RU`,`pds_valves`.`tag_EN` AS `tag_EN`,`pds_valves`.`Type` AS `Type`,`pds_valves`.`station_sys` AS `station_sys`,`pds_valves`.`Department` AS `Department`,`pds_valves`.`Desc` AS `Desc_RU`,`pds_valves`.`Desc_EN` AS `Desc_EN`,`pds_valves`.`PowerTemp` AS `PowerTemp`,`pds_valves`.`ed_power` AS `ed_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`ed_power`)) AS `ed_power`,`pds_valves`.`ctrl_power` AS `ctrl_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`ctrl_power`)) AS `ctrl_power`,`pds_valves`.`anc_power` AS `anc_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`anc_power`)) AS `anc_power`,`pds_valves`.`nom_state` AS `nom_state`,`pds_valves`.`open_rate` AS `open_rate`,`pds_valves`.`close_rate` AS `close_rate`,`pds_valves`.`Algorithm` AS `Algorithm`,`pds_valves`.`model` AS `model`,`pds_valves`.`connection` AS `connection`,(select `pds_man_equip`.`Type` AS `Type` from `pds_man_equip` where (`pds_man_equip`.`EquipN` = `pds_valves`.`eq_type`)) AS `eq_type` from (`pds_valves` left join `pds_syslist` on((`pds_valves`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_valves`.`Project` = 200000001))', force: true
  create_view 'pds_valves_73', '(select `pds_valves`.`t` AS `t`,`pds_valves`.`mod` AS `mod`,`pds_valves`.`import_t` AS `import_t`,`pds_valves`.`valveID` AS `valveID`,`pds_valves`.`sys` AS `SystemID`,`pds_syslist`.`System` AS `sys`,`pds_valves`.`tag_RU` AS `tag_RU`,`pds_valves`.`tag_EN` AS `tag_EN`,`pds_valves`.`Type` AS `Type`,`pds_valves`.`station_sys` AS `station_sys`,`pds_valves`.`Department` AS `Department`,`pds_valves`.`Desc` AS `Desc_RU`,`pds_valves`.`Desc_EN` AS `Desc_EN`,`pds_valves`.`PowerTemp` AS `PowerTemp`,`pds_valves`.`ed_power` AS `ed_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`ed_power`)) AS `ed_power`,`pds_valves`.`ctrl_power` AS `ctrl_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`ctrl_power`)) AS `ctrl_power`,`pds_valves`.`anc_power` AS `anc_powerID`,(select `pds_section_assembler`.`section_name` AS `section_name` from `pds_section_assembler` where (`pds_section_assembler`.`section_N` = `pds_valves`.`anc_power`)) AS `anc_power`,`pds_valves`.`nom_state` AS `nom_state`,`pds_valves`.`open_rate` AS `open_rate`,`pds_valves`.`close_rate` AS `close_rate`,`pds_valves`.`Algorithm` AS `Algorithm`,`pds_valves`.`model` AS `model`,`pds_valves`.`connection` AS `connection`,(select `pds_man_equip`.`Type` AS `Type` from `pds_man_equip` where (`pds_man_equip`.`EquipN` = `pds_valves`.`eq_type`)) AS `eq_type` from (`pds_valves` left join `pds_syslist` on((`pds_valves`.`sys` = `pds_syslist`.`SystemID`))) where (`pds_valves`.`Project` = 200000005))', force: true
  create_view 'project_list', "(select `pds_project`.`ProjectID` AS `ProjectID`,concat(`pds_project`.`project_number`,'/',`pds_project`.`project_name`) AS `Project` from (`pds_project` left join `pds_project_properties` on((`pds_project`.`ProjectID` = `pds_project_properties`.`ProjectID`))) where (`pds_project_properties`.`ProjectID` is not null))", force: true
  create_table 'roles', primary_key: 'roleID', force: true do |t|
    t.string 'role', limit: 5, null: false
    t.string 'Desc', limit: 50
    t.index ['roleID'], name: 'roleID', unique: true
  end

  create_table 'roles_eng_prj', id: false, force: true do |t|
    t.integer 'roleID', limit: 1, null: false
    t.integer 'engineer_N',           null: false
    t.integer 'ProjectID',            null: false
    t.index ['ProjectID'], name: 'projectID'
    t.index ['engineer_N'], name: 'engineer_N'
    t.index ['roleID'], name: 'roleID'
    t.foreign_key ['ProjectID'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :cascade, name: 'roles_eng_prj_ibfk_3'
    t.foreign_key ['engineer_N'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :cascade, name: 'roles_eng_prj_ibfk_2'
    t.foreign_key ['roleID'], 'roles', ['roleID'], on_update: :cascade, on_delete: :cascade, name: 'roles_eng_prj_ibfk_1'
  end

  create_table 'sector', primary_key: 'sID', force: true do |t|
    t.string  'sName', null: false
    t.integer 'Manager_ID'
  end

  create_table 'sign_rpt', primary_key: 'sID', force: true do |t|
    t.integer 'engID', null: false
    t.string  'engName', default: ''
    t.integer 'BlobObj'
    t.index ['BlobObj'], name: 'FK_sign_rpt_BlobObj'
    t.index ['engID'], name: 'FK_sign_rpt'
    t.foreign_key ['BlobObj'], 'tblbinaries', ['ObjectID'], on_update: :cascade, on_delete: :cascade, name: 'FK_sign_rpt_BlobObj'
    t.foreign_key ['engID'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :cascade, name: 'FK_sign_rpt'
  end

  create_table 'table_role_rights', id: false, force: true do |t|
    t.integer 'tableID', limit: 1, null: false
    t.integer 'roleID',  limit: 1, null: false
    t.integer 'value',   limit: 1, null: false
    t.index ['roleID'], name: 'roleID'
    t.index ['tableID'], name: 'tableID'
    t.foreign_key ['roleID'], 'roles', ['roleID'], on_update: :cascade, on_delete: :cascade, name: 'table_role_rights_ibfk_3'
    t.foreign_key ['tableID'], 'tablelist', ['tableID'], on_update: :cascade, on_delete: :cascade, name: 'table_role_rights_ibfk_2'
  end

  create_table 'test', force: true do |t|
    t.integer 'llim'
    t.integer 'ulim'
    t.integer 'new_id'
    t.string  'table'
  end

  create_table 'week_report', primary_key: 'ReportID', force: true do |t|
    t.integer  'Project', null: false
    t.integer  'Engineer'
    t.datetime 'ReportDate'
    t.integer  'sys'
    t.text     'RptText'
    t.text     'Problems'
    t.time     't'
    t.index ['Engineer'], name: 'Engineer'
    t.index ['Project'], name: 'Project'
    t.index ['ReportID'], name: 'ReportID', unique: true
    t.index ['sys'], name: 'sys'
    t.foreign_key ['Engineer'], 'pds_engineers', ['engineer_N'], on_update: :cascade, on_delete: :cascade, name: 'week_report_ibfk_1'
    t.foreign_key ['Project'], 'pds_project', ['ProjectID'], on_update: :cascade, on_delete: :restrict, name: 'week_report_ibfk_5'
    t.foreign_key ['sys'], 'pds_syslist', ['SystemID'], on_update: :restrict, on_delete: :restrict, name: 'week_report_ibfk_4'
  end
end
