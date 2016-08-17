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
  create_table 'acc', id: false, force: :cascade do |t|
    t.integer 'Project',   limit: 4, null: false
    t.string  'ped',       limit: 32
    t.string  'Name',      limit: 33
    t.integer 'number',    limit: 1
    t.string  'SH',        limit: 4
    t.string  'SV',        limit: 4
    t.text    'tag_no',    limit: 65_535
    t.string  'store',     limit: 255
    t.float   'scale_min', limit: 53
    t.float   'scale_max', limit: 53
    t.string  'Unit',      limit: 8
    t.string  'MP_CMEMO',  limit: 256
    t.string  'panel',     limit: 33
    t.integer 'revision',  limit: 4, null: false
    t.string  'MP_TYPE0',  limit: 32
  end

  create_table 'acc_ic', id: false, force: :cascade do |t|
    t.integer 'Project',   limit: 4, null: false
    t.string  'ref',       limit: 32
    t.string  'ped',       limit: 32
    t.text    'tag_no',    limit: 65_535
    t.string  'Надпись',   limit: 255
    t.float   'scale_min', limit: 53
    t.float   'scale_max', limit: 53
    t.string  'Unit',      limit: 8
    t.string  'MP_CMEMO',  limit: 256
    t.string  'panel',     limit: 33
    t.integer 'revision',  limit: 4, null: false
  end

  create_table 'as', force: :cascade do |t|
    t.string 'a', limit: 32
    t.string 'b', limit: 32
  end

  create_table 'audit', primary_key: 'auditID', force: :cascade do |t|
    t.integer  'Project',       limit: 4, null: false, index: { name: 'PRJ_KEY', using: :btree }
    t.string   'table_name',    limit: 64, null: false
    t.string   'tag_RU',        limit: 64
    t.string   'tag_EN',        limit: 64
    t.string   'sys',           limit: 64
    t.string   'field_changed', limit: 64, null: false
    t.integer  'id',            limit: 4, null: false
    t.text     'old_value',     limit: 65_535
    t.text     'new_value',     limit: 65_535
    t.datetime 't',             null: false
  end

  create_table 'company', primary_key: 'cID', force: :cascade do |t|
    t.string 'shortName',       limit: 64, null: false
    t.string 'shortName_en',    limit: 64
    t.string 'LongName',        limit: 255, null: false
    t.string 'LongName_en',     limit: 255
    t.text   'Descriprion',     limit: 16_777_215
    t.binary 'Logo',            limit: 16_777_215
    t.string 'AcceptorPost_en', limit: 255
    t.string 'AcceptorPost',    limit: 255
    t.string 'AcceptorName_en', limit: 64
    t.string 'AcceptorName',    limit: 64
  end

  create_table 'contract', primary_key: 'ID', force: :cascade do |t|
    t.string  'contr_Num', limit: 64, null: false
    t.integer 'Project',   limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string  'state',     limit: 21
    t.date    'date'
    t.string  'Desc', limit: 255
  end

  create_table 'detectors_valves_motors_breakers_85', id: false, force: :cascade do |t|
    t.string 'tag',   limit: 255
    t.string 'table', limit: 21
  end

  create_table 'detectors_valves_motors_breakers_filter_hex_rf_volume_85', id: false, force: :cascade do |t|
    t.string 'tag',   limit: 255
    t.string 'table', limit: 13, default: '', null: false
  end

  create_table 'dr_stats', id: false, force: :cascade do |t|
    t.integer 'Project',      limit: 4, null: false
    t.integer 'sys',          limit: 4
    t.string  'sysname',      limit: 8
    t.string  'sys_eng_name', limit: 255
    t.string  'Status',       limit: 17
    t.integer 'number',       limit: 8, default: 0, null: false
  end

  create_table 'dwg_panels', primary_key: 'dp_id', force: :cascade do |t|
    t.integer  'Project',    limit: 4, null: false, index: { name: 'FK_dwg_panels1', using: :btree }
    t.boolean  'panel',      default: true, null: false
    t.string   'NAME',       limit: 33, index: { name: 'panel_index', using: :btree }
    t.string   'EV',         limit: 4
    t.integer  'EH',         limit: 1
    t.string   'SV',         limit: 4
    t.integer  'SH',         limit: 1
    t.string   'MP_CMEMO',   limit: 256
    t.string   'MP_CODE',    limit: 33
    t.string   'MP_CODE1',   limit: 255
    t.string   'MP_CODE2',   limit: 255
    t.string   'MP_L0',      limit: 255
    t.string   'MP_L0_0',    limit: 127
    t.string   'MP_L0_1',    limit: 127
    t.string   'MP_L0_2',    limit: 127
    t.string   'MP_L0_3',    limit: 127
    t.string   'MP_L0_4',    limit: 127
    t.integer  'MP_L0_0_x',  limit: 4
    t.integer  'MP_L0_0_y',  limit: 4
    t.integer  'MP_L0_0_w',  limit: 4
    t.integer  'MP_L0_0_h',  limit: 4
    t.integer  'MP_L0_0_f',  limit: 4
    t.integer  'MP_L0_1_x',  limit: 4
    t.integer  'MP_L0_1_y',  limit: 4
    t.integer  'MP_L0_1_w',  limit: 4
    t.integer  'MP_L0_1_h',  limit: 4
    t.integer  'MP_L0_1_f',  limit: 4
    t.integer  'MP_L0_2_x',  limit: 4
    t.integer  'MP_L0_2_y',  limit: 4
    t.integer  'MP_L0_2_w',  limit: 4
    t.integer  'MP_L0_2_h',  limit: 4
    t.integer  'MP_L0_2_f',  limit: 4
    t.integer  'MP_L0_3_x',  limit: 4
    t.integer  'MP_L0_3_y',  limit: 4
    t.integer  'MP_L0_3_w',  limit: 4
    t.integer  'MP_L0_3_h',  limit: 4
    t.integer  'MP_L0_3_f',  limit: 4
    t.integer  'MP_L0_4_x',  limit: 4
    t.integer  'MP_L0_4_y',  limit: 4
    t.integer  'MP_L0_4_w',  limit: 4
    t.integer  'MP_L0_4_h',  limit: 4
    t.integer  'MP_L0_4_f',  limit: 4
    t.integer  'MP_MASS',    limit: 1
    t.float    'MP_MAX',     limit: 53
    t.float    'MP_MIN',     limit: 53
    t.string   'MP_MODE',    limit: 4
    t.integer  'MP_MODEORD', limit: 1
    t.string   'MP_NAME0',   limit: 64
    t.string   'MP_NAME1',   limit: 64
    t.string   'MP_ORDER',   limit: 32
    t.integer  'MP_PROJ',    limit: 4
    t.integer  'MP_S0',      limit: 4
    t.integer  'MP_S100',    limit: 4
    t.integer  'MP_S20',     limit: 4
    t.integer  'MP_S40',     limit: 4
    t.integer  'MP_S50',     limit: 4
    t.string   'MP_S60',     limit: 32
    t.integer  'MP_S80',     limit: 4
    t.string   'MP_TYPE0',   limit: 32
    t.string   'MP_TYPE1',   limit: 32, index: { name: 'ped_index', using: :btree }
    t.string   'MP_U0',      limit: 8, index: { name: 'unit_index', using: :btree }
    t.string   'MP_U1',      limit: 8
    t.string   'MP_IO',      limit: 8
    t.string   'MP_IOCONT',  limit: 8
    t.string   'MP_IONAME',  limit: 8
    t.string   'TYPE',       limit: 32
    t.decimal  'FONT',       precision: 5, scale: 2
    t.integer  'MIRROR',     limit: 1
    t.decimal  'ROTATE',     precision: 6, scale: 2
    t.integer  'revision',   limit: 4, null: false
    t.datetime 't',          null: false
    t.integer  'rotation',   limit: 4, default: 0
    t.string   'ref',        limit: 32
  end

  create_table 'dwg_type_rotations', primary_key: 'tr_id', force: :cascade do |t|
    t.integer 'Project',    limit: 4, index: { name: 'FK_dwg_type_rotations', using: :btree }
    t.string  'type',       limit: 128, null: false
    t.integer 'rotation',   limit: 4
    t.integer 'reflection', limit: 4
  end
  add_index 'dwg_type_rotations', ['Project'], name: 'FK_dwg_type_rotations1', using: :btree

  create_table 'for_sapphire', id: false, force: :cascade do |t|
    t.integer  'dp_id',      limit: 4, default: 0, null: false
    t.integer  'Project',    limit: 4, null: false
    t.boolean  'panel',      default: true, null: false
    t.string   'NAME',       limit: 33
    t.string   'EV',         limit: 4
    t.integer  'EH',         limit: 1
    t.string   'SV',         limit: 4
    t.integer  'SH',         limit: 1
    t.string   'MP_CMEMO',   limit: 256
    t.string   'MP_CODE',    limit: 330
    t.string   'MP_CODE1',   limit: 255
    t.string   'MP_CODE2',   limit: 255
    t.string   'MP_L0',      limit: 255
    t.integer  'MP_MASS',    limit: 1
    t.float    'MP_MAX',     limit: 53
    t.float    'MP_MIN',     limit: 53
    t.string   'MP_MODE',    limit: 4
    t.integer  'MP_MODEORD', limit: 1
    t.string   'MP_NAME0',   limit: 64
    t.string   'MP_NAME1',   limit: 64
    t.string   'MP_ORDER',   limit: 32
    t.integer  'MP_PROJ',    limit: 4
    t.integer  'MP_S0',      limit: 4
    t.integer  'MP_S100',    limit: 4
    t.integer  'MP_S20',     limit: 4
    t.integer  'MP_S40',     limit: 4
    t.integer  'MP_S50',     limit: 4
    t.string   'MP_S60',     limit: 32
    t.integer  'MP_S80',     limit: 4
    t.string   'MP_TYPE0',   limit: 32
    t.string   'MP_TYPE1',   limit: 32
    t.string   'MP_U0',      limit: 8
    t.string   'MP_U1',      limit: 8
    t.string   'MP_IO',      limit: 8
    t.string   'MP_IOCONT',  limit: 8
    t.string   'MP_IONAME',  limit: 8
    t.string   'TYPE',       limit: 32
    t.decimal  'FONT',       precision: 5, scale: 2
    t.integer  'MIRROR',     limit: 1
    t.decimal  'ROTATE',     precision: 6, scale: 2
    t.integer  'revision',   limit: 4, null: false
    t.datetime 't',          null: false
    t.integer  'rotation',   limit: 4, default: 0
    t.string   'ref',        limit: 32
    t.string   'MP_L0_1',    limit: 127
    t.string   'MP_L0_2',    limit: 127
    t.string   'MP_L0_3',    limit: 127
    t.string   'MP_L0_4',    limit: 127
    t.integer  'MP_L0_0_x',  limit: 4
    t.integer  'MP_L0_0_y',  limit: 4
    t.integer  'MP_L0_0_w',  limit: 4
    t.integer  'MP_L0_0_h',  limit: 4
    t.integer  'MP_L0_0_f',  limit: 4
    t.integer  'MP_L0_1_x',  limit: 4
    t.integer  'MP_L0_1_y',  limit: 4
    t.integer  'MP_L0_1_w',  limit: 4
    t.integer  'MP_L0_1_h',  limit: 4
    t.integer  'MP_L0_1_f',  limit: 4
    t.integer  'MP_L0_2_x',  limit: 4
    t.integer  'MP_L0_2_y',  limit: 4
    t.integer  'MP_L0_2_w',  limit: 4
    t.integer  'MP_L0_2_h',  limit: 4
    t.integer  'MP_L0_2_f',  limit: 4
    t.integer  'MP_L0_3_x',  limit: 4
    t.integer  'MP_L0_3_y',  limit: 4
    t.integer  'MP_L0_3_w',  limit: 4
    t.integer  'MP_L0_3_h',  limit: 4
    t.integer  'MP_L0_3_f',  limit: 4
    t.integer  'MP_L0_4_x',  limit: 4
    t.integer  'MP_L0_4_y',  limit: 4
    t.integer  'MP_L0_4_w',  limit: 4
    t.integer  'MP_L0_4_h',  limit: 4
    t.integer  'MP_L0_4_f',  limit: 4
  end

  create_table 'hw_devtype', primary_key: 'typeID', force: :cascade do |t|
    t.string  'RuName',    limit: 31
    t.string  'EnName',    limit: 31
    t.integer 'typetable', limit: 1, index: { name: 'typetable', using: :btree }
  end
  add_index 'hw_devtype', ['typeID'], name: 'typeID', unique: true, using: :btree

  create_table 'hw_ic', primary_key: 'icID', force: :cascade do |t|
    t.integer  'Project',        limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'ref',            limit: 128, index: { name: 'ref', using: :btree }
    t.integer  'ped',            limit: 4, index: { name: 'ped_N', using: :btree }
    t.string   'rev',            limit: 1
    t.string   'tag_no',         limit: 330
    t.string   'UniquePTAG',     limit: 330
    t.string   'un',             limit: 2
    t.string   'bv',             limit: 11
    t.string   'panel',          limit: 32
    t.string   'coord',          limit: 6
    t.float    'scaleMin',       limit: 53
    t.float    'scaleMax',       limit: 53
    t.integer  'Unit',           limit: 4, index: { name: 'Unit', using: :btree }
    t.string   'Description',    limit: 1000
    t.datetime 't',              null: false
    t.string   'Type',           limit: 1
    t.integer  'sys',            limit: 4, index: { name: 'sys', using: :btree }
    t.text     'Description_EN', limit: 65_535
    t.integer  'panel_id',       limit: 4, index: { name: 'FK_hw_ic22', using: :btree }
    t.string   'suffix',         limit: 10
    t.integer  'version',        limit: 1, default: 1
    t.string   'mark',           limit: 32
  end
  add_index 'hw_ic', ['icID'], name: 'icID', unique: true, using: :btree

  create_table 'hw_ic_sys', id: false, force: :cascade do |t|
    t.integer 'sys', limit: 4
    t.integer 'IC',  limit: 4
  end

  create_table 'hw_ic_temp', primary_key: 'icID', force: :cascade do |t|
    t.integer  'Project',        limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'ref',            limit: 128, index: { name: 'ref', using: :btree }
    t.integer  'ped',            limit: 4, index: { name: 'ped_N', using: :btree }
    t.string   'rev',            limit: 1
    t.string   'tag_no',         limit: 330
    t.string   'UniquePTAG',     limit: 128
    t.string   'un',             limit: 2
    t.string   'bv',             limit: 11
    t.string   'panel',          limit: 32
    t.string   'coord',          limit: 6
    t.float    'scaleMin',       limit: 53
    t.float    'scaleMax',       limit: 53
    t.string   'UnitText',       limit: 32
    t.string   'Description',    limit: 1000
    t.datetime 't',              null: false
    t.string   'Type',           limit: 1
    t.text     'Description_EN', limit: 65_535
    t.integer  'version',        limit: 1, default: 1
    t.string   'suffix',         limit: 10
    t.integer  'Unit',           limit: 4
    t.string   'ic_r',           limit: 255
    t.string   'action',         limit: 16
  end
  add_index 'hw_ic_temp', ['icID'], name: 'icID', unique: true, using: :btree

  create_table 'hw_iosignal', primary_key: 'ID', force: :cascade do |t|
    t.integer  'Project',     limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'pedID',       limit: 4, null: false, index: { name: 'pedID', using: :btree }
    t.integer  'signID',      limit: 4, null: false, index: { name: 'signID', using: :btree }
    t.integer  'wirecode',    limit: 4
    t.string   'contact',     limit: 16
    t.string   'sw_pref',     limit: 15
    t.string   'sw_suff',     limit: 15
    t.string   'hw_suff',     limit: 15
    t.string   'comment',     limit: 32
    t.integer  'contactnum',  limit: 2
    t.string   'description', limit: 64
    t.string   'diapason',    limit: 128
    t.string   'limits',      limit: 32
    t.datetime 't',           null: false
    t.integer  'temp',        limit: 4
  end
  add_index 'hw_iosignal', ['ID'], name: 'ID', unique: true, using: :btree

  create_table 'hw_iosignaldef', primary_key: 'ID', force: :cascade do |t|
    t.string 'ioname',  limit: 15, null: false, index: { name: 'ioname', unique: true, using: :btree }
    t.string 'memtype', limit: 2, default: '-'
    t.string 'rem',     limit: 30
  end
  add_index 'hw_iosignaldef', ['ID'], name: 'ioID', unique: true, using: :btree

  create_table 'hw_iosignaldim', primary_key: 'ID', force: :cascade do |t|
    t.integer 'Project', limit: 4, null: false, index: { name: 'FK_hw_iosignaldim1', using: :btree }
    t.integer 'signID',  limit: 4, null: false, index: { name: 'signID', with: %w(num type Project), unique: true, using: :btree }
    t.integer 'num',     limit: 4
    t.string  'type',    limit: 3, default: 'ALL', null: false
    t.string  'suff',    limit: 32, default: ''
  end

  create_table 'hw_peds', primary_key: 'ped_N', force: :cascade do |t|
    t.integer  'Project',   limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'ped',       limit: 32, default: '', null: false, index: { name: 'ped', with: ['Project'], unique: true, using: :btree }
    t.string   'Code',      limit: 50
    t.integer  'AI',        limit: 4, default: 0
    t.integer  'AO',        limit: 4, default: 0
    t.integer  'AO*',       limit: 4, default: 0
    t.integer  'DI',        limit: 4, default: 0
    t.integer  'LO',        limit: 4, default: 0
    t.integer  'LO*',       limit: 4, default: 0
    t.integer  'LO+',       limit: 4, default: 0
    t.integer  'LO220',     limit: 4, default: 0
    t.integer  'RO',        limit: 4, default: 0
    t.integer  'DO',        limit: 4, default: 0
    t.integer  'IOSUM',     limit: 4
    t.float    '5VDC',      limit: 53, default: 0.0
    t.float    '24VDC',     limit: 53, default: 0.0
    t.float    '10VDC',     limit: 53, default: 0.0
    t.float    '12VDC',     limit: 53, default: 0.0
    t.float    '60VDC',     limit: 53, default: 0.0
    t.float    '100VDC',    limit: 53, default: 0.0
    t.float    '9VDC',      limit: 53, default: 0.0
    t.float    '220VAC',    limit: 53, default: 0.0
    t.float    '1,2VAC',    limit: 53, default: 0.0
    t.float    '1,5VAC',    limit: 53, default: 0.0
    t.float    '2,5VAC',    limit: 53, default: 0.0
    t.float    '5VAC',      limit: 53, default: 0.0
    t.integer  'type',      limit: 4, index: { name: 'type', using: :btree }
    t.string   'VENDOR',    limit: 30
    t.string   'DESCRIPT',  limit: 64
    t.string   'REM',       limit: 64
    t.datetime 't',         null: false
    t.string   'GenExtSig', limit: 3, default: 'да', null: false
  end
  add_index 'hw_peds', ['ped_N'], name: 'ped_N', unique: true, using: :btree

  create_table 'hw_peds_copy', primary_key: 'ped_N', force: :cascade do |t|
    t.integer  'ped_NNN',   limit: 4
    t.integer  'ped_NN',    limit: 4
    t.integer  'Project',   limit: 4, null: false
    t.string   'ped',       limit: 32, default: '', null: false
    t.string   'Code',      limit: 50
    t.integer  'AI',        limit: 4, default: 0
    t.integer  'AO',        limit: 4, default: 0
    t.integer  'AO*',       limit: 4, default: 0
    t.integer  'DI',        limit: 4, default: 0
    t.integer  'LO',        limit: 4, default: 0
    t.integer  'LO*',       limit: 4, default: 0
    t.integer  'LO+',       limit: 4, default: 0
    t.integer  'LO220',     limit: 4, default: 0
    t.integer  'RO',        limit: 4, default: 0
    t.integer  'DO',        limit: 4, default: 0
    t.integer  'IOSUM',     limit: 4
    t.float    '5VDC',      limit: 53, default: 0.0
    t.float    '24VDC',     limit: 53, default: 0.0
    t.float    '10VDC',     limit: 53, default: 0.0
    t.float    '12VDC',     limit: 53, default: 0.0
    t.float    '60VDC',     limit: 53, default: 0.0
    t.float    '100VDC',    limit: 53, default: 0.0
    t.float    '9VDC',      limit: 53, default: 0.0
    t.float    '220VAC',    limit: 53, default: 0.0
    t.float    '1,2VAC',    limit: 53, default: 0.0
    t.float    '1,5VAC',    limit: 53, default: 0.0
    t.float    '2,5VAC',    limit: 53, default: 0.0
    t.float    '5VAC',      limit: 53, default: 0.0
    t.integer  'type',      limit: 4, index: { name: 'type', using: :btree }
    t.string   'VENDOR',    limit: 30
    t.string   'DESCRIPT',  limit: 64
    t.string   'REM',       limit: 64
    t.datetime 't',         null: false
    t.string   'GenExtSig', limit: 3, default: 'да', null: false
  end
  add_index 'hw_peds_copy', ['ped_N'], name: 'ped_N', unique: true, using: :btree

  create_table 'hw_wirelist', primary_key: 'wirelist_N', force: :cascade do |t|
    t.string   'from',        limit: 255
    t.string   'to',          limit: 255
    t.string   'wc',          limit: 11
    t.string   'nc',          limit: 255
    t.string   'io',          limit: 4
    t.integer  'm',           limit: 4
    t.integer  's',           limit: 4
    t.integer  'word',        limit: 4
    t.string   'bit',         limit: 255
    t.string   'power',       limit: 255
    t.string   'origin',      limit: 255
    t.string   'net',         limit: 255
    t.integer  'ped',         limit: 4, index: { name: 'ped_N', using: :btree }
    t.integer  'Project',     limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'rev',         limit: 255
    t.integer  'Unit',        limit: 4, index: { name: 'Unit', using: :btree }
    t.integer  'step',        limit: 4, default: 0
    t.datetime 't',           null: false
    t.integer  'IC',          limit: 4, index: { name: 'IC', using: :btree }
    t.string   'remarks',     limit: 255
    t.integer  'io_signalID', limit: 4, index: { name: 'io_signalID', using: :btree }
    t.string   'panel',       limit: 32
    t.string   'pds_mark',    limit: 8
  end
  add_index 'hw_wirelist', ['wirelist_N'], name: 'wirelist_N', unique: true, using: :btree

  create_table 'input_letters', primary_key: 'InputLettersID', force: :cascade do |t|
    t.date     'Date'
    t.integer  'To',      limit: 4, index: { name: 'To', using: :btree }
    t.integer  'From',    limit: 4, index: { name: 'From', using: :btree }
    t.string   'Number',  limit: 30
    t.integer  'BlobObj', limit: 4, index: { name: 'BlobObj', using: :btree }
    t.datetime 't',       null: false
  end
  add_index 'input_letters', ['InputLettersID'], name: 'InputLetersID', unique: true, using: :btree

  create_table 'lettrs_adressat', primary_key: 'adressatID', force: :cascade do |t|
    t.string 'Name',        limit: 30
    t.string 'ShortAdress', limit: 30, index: { name: 'ShortAdress', using: :btree }
    t.string 'Adress',      limit: 100
    t.string 'JobTitle',    limit: 30
  end
  add_index 'lettrs_adressat', ['adressatID'], name: 'adressatID', unique: true, using: :btree

  create_table 'news', primary_key: 'newsID', force: :cascade do |t|
    t.text     'news', limit: 65_535
    t.datetime 't',    null: false
    t.date     'date'
  end
  add_index 'news', ['newsID'], name: 'newsID', unique: true, using: :btree

  create_table 'panels_revisions', id: false, force: :cascade do |t|
    t.integer 'max_revision', limit: 4
    t.string  'NAME',         limit: 33
    t.integer 'Project',      limit: 4, null: false
  end

  create_table 'pds_air_valves', primary_key: 'AvalvesID', force: :cascade do |t|
    t.integer 'sys',            limit: 4, index: { name: 'sys', using: :btree }
    t.integer 'Project',        limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string  'tag',            limit: 10
    t.string  'Description',    limit: 255
    t.string  'Description_EN', limit: 255
    t.integer 'Open',           limit: 4
    t.integer 'Close',          limit: 4
    t.integer 'ctrl_power',     limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.integer 'Air_power',      limit: 4
  end
  add_index 'pds_air_valves', ['AvalvesID'], name: 'AvalvesID', unique: true, using: :btree

  create_table 'pds_alarm', primary_key: 'AlarmID', force: :cascade do |t|
    t.integer  'IC',      limit: 4, null: false, index: { name: 'IC', using: :btree }
    t.integer  'sys',     limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project', limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.datetime 't',       null: false
  end
  add_index 'pds_alarm', ['AlarmID'], name: 'AlarmID', unique: true, using: :btree

  create_table 'pds_alg_type', primary_key: 'algID', force: :cascade do |t|
    t.integer 'Project',  limit: 4, null: false
    t.string  'alg_type', limit: 16, null: false
    t.integer 'numb',     limit: 4
  end

  create_table 'pds_algo_inputs', primary_key: 'InptID', force: :cascade do |t|
    t.integer 'Algorithm',      limit: 4, null: false, index: { name: 'Algorithm', using: :btree }
    t.string  'Name',           limit: 255, null: false
    t.string  'Description',    limit: 255
    t.string  'Description_EN', limit: 255
    t.string  'varname',        limit: 255, null: false
    t.integer 'Type',           limit: 4
    t.integer 'Unit',           limit: 4, index: { name: 'Unit', using: :btree }
  end
  add_index 'pds_algo_inputs', ['InptID'], name: 'InptID', unique: true, using: :btree

  create_table 'pds_algo_outs', primary_key: 'OutID', force: :cascade do |t|
    t.integer 'Algorithm',   limit: 4, null: false, index: { name: 'Algorithm', using: :btree }
    t.string  'Name',        limit: 255, null: false
    t.string  'Description', limit: 255
    t.integer 'Unit',        limit: 4, index: { name: 'Unit', using: :btree }
    t.string  'varname',     limit: 255, null: false
  end
  add_index 'pds_algo_outs', ['OutID'], name: 'OutID', unique: true, using: :btree

  create_table 'pds_algorithms', primary_key: 'AlgoID', force: :cascade do |t|
    t.string  'Name', limit: 255, null: false
    t.binary  'Data', limit: 16_777_215
    t.integer 'sys',  limit: 4, null: false, index: { name: 'sys', using: :btree }
  end
  add_index 'pds_algorithms', ['AlgoID'], name: 'AlgoID', unique: true, using: :btree

  create_table 'pds_announciator', primary_key: 'AnnouncID', force: :cascade do |t|
    t.integer  'IC',              limit: 4, index: { name: 'IC', using: :btree }
    t.integer  'Project',         limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'sys',             limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'ctrl_power',      limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.datetime 't',               null: false
    t.string   'Type',            limit: 2
    t.string   'Gr_Dreg',         limit: 50
    t.integer  'Detector',        limit: 4, index: { name: 'Detector', using: :btree }
    t.string   'Characteristics', limit: 50
    t.string   'sign',            limit: 8
    t.string   'Code',            limit: 50
  end
  add_index 'pds_announciator', ['AnnouncID'], name: 'AnnouncID', unique: true, using: :btree

  create_table 'pds_blocks', primary_key: 'blockID', force: :cascade do |t|
    t.integer 'sys',     limit: 4, index: { name: 'sys', using: :btree }
    t.string  'p_p',     limit: 15
    t.text    'Desc',    limit: 65_535
    t.integer 'doc',     limit: 4, index: { name: 'doc', using: :btree }
    t.string  'varName', limit: 32
    t.integer 'Project', limit: 4, null: false, index: { name: 'Project', using: :btree }
  end
  add_index 'pds_blocks', ['blockID'], name: 'blockID', unique: true, using: :btree

  create_table 'pds_blocks_systems', primary_key: 'ID', force: :cascade do |t|
    t.integer 'block', limit: 4, null: false, index: { name: 'block', using: :btree }
    t.integer 'sys',   limit: 4, null: false, index: { name: 'sys', using: :btree }
  end
  add_index 'pds_blocks_systems', ['ID'], name: 'ID', unique: true, using: :btree

  create_table 'pds_breakers', primary_key: 'BreakerID', force: :cascade do |t|
    t.integer 'sys',        limit: 4, index: { name: 'sys', using: :btree }
    t.integer 'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string  'tag_RU',     limit: 255, default: ''
    t.string  'tag_EN',     limit: 255
    t.integer 'ed_power',   limit: 4, index: { name: 'FK_pds_breakers_ed_power1', using: :btree }
    t.integer 'ctrl_power', limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.integer 'anc_power',  limit: 4, index: { name: 'anc_power', using: :btree }
    t.float   'Time',       limit: 53
    t.string  'Algorithm',  limit: 50
    t.string  'Desc_RU',    limit: 255
    t.string  'Desc_EN',    limit: 255
    t.string  'model',      limit: 64
    t.integer 'eq_type',    limit: 4, index: { name: 'FK_pds_breakers_eq_type1', using: :btree }
    t.string  'connection', limit: 64
    t.integer 'sd_N',       limit: 4, index: { name: 'sd_N', using: :btree }
  end
  add_index 'pds_breakers', ['BreakerID'], name: 'BreakerID', unique: true, using: :btree

  create_table 'pds_breakers_60', id: false, force: :cascade do |t|
    t.string 'System',  limit: 8, default: ''
    t.string 'tag_RU',  limit: 255, default: ''
    t.string 'tag_EN',  limit: 255
    t.string 'Desc_RU', limit: 255
    t.string 'Desc_EN', limit: 255
  end

  create_table 'pds_breakers_62', id: false, force: :cascade do |t|
    t.string 'System',  limit: 8, default: ''
    t.string 'tag_RU',  limit: 255, default: ''
    t.string 'tag_EN',  limit: 255
    t.string 'Desc_RU', limit: 255
    t.string 'Desc_EN', limit: 255
  end

  create_table 'pds_breakers_73', id: false, force: :cascade do |t|
    t.string 'System',  limit: 8, default: ''
    t.string 'tag_RU',  limit: 255, default: ''
    t.string 'tag_EN',  limit: 255
    t.string 'Desc_RU', limit: 255
    t.string 'Desc_EN', limit: 255
  end

  create_table 'pds_bru', primary_key: 'BRUID', force: :cascade do |t|
    t.integer  'IC',         limit: 4, null: false, index: { name: 'IC', using: :btree }
    t.integer  'sys',        limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.datetime 't',          null: false
    t.integer  'ctrl_power', limit: 4, index: { name: 'ctrl_power', using: :btree }
  end
  add_index 'pds_bru', ['BRUID'], name: 'BRUID', unique: true, using: :btree

  create_table 'pds_buttons', primary_key: 'ButtonID', force: :cascade do |t|
    t.integer  'IC',      limit: 4, null: false, index: { name: 'IC', using: :btree }
    t.integer  'sys',     limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project', limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.text     'range',   limit: 16_777_215
    t.boolean  'Fixed',   default: false
    t.datetime 't',       null: false
  end
  add_index 'pds_buttons', ['ButtonID'], name: 'ButtonID', unique: true, using: :btree

  create_table 'pds_buttons_lights', primary_key: 'ButtonID', force: :cascade do |t|
    t.integer  'IC',         limit: 4, null: false, index: { name: 'IC', using: :btree }
    t.integer  'sys',        limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'ctrl_power', limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.text     'range',      limit: 16_777_215
    t.boolean  'Fixed',      default: false
    t.datetime 't',          null: false
  end
  add_index 'pds_buttons_lights', ['ButtonID'], name: 'ButtonID', unique: true, using: :btree

  create_table 'pds_customers', primary_key: 'customerID', force: :cascade do |t|
    t.integer  'Project',              limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'AgreeName',            limit: 50, null: false
    t.datetime 't',                    null: false
    t.string   'AgreeJobTitle',        limit: 50
    t.string   'AgreeJobTitle_EN',     limit: 50
    t.string   'AcceptedName1',        limit: 50
    t.string   'AcceptedJobTitle1',    limit: 50
    t.string   'AcceptedJobTitle1_EN', limit: 50
    t.string   'AcceptedName2',        limit: 50
    t.string   'AcceptedJobTitle2',    limit: 50
    t.string   'AcceptedJobTitle2_EN', limit: 50
    t.string   'Name',                 limit: 50
  end
  add_index 'pds_customers', ['customerID'], name: 'customer_N', unique: true, using: :btree

  create_table 'pds_detectors', primary_key: 'DetID', force: :cascade do |t|
    t.integer  'Project',      limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'sys',          limit: 4, index: { name: 'sys', using: :btree }
    t.string   'station_sys',  limit: 30
    t.string   'tag',          limit: 255, default: ''
    t.string   'tag_RU',       limit: 255
    t.string   'Desc',         limit: 255
    t.string   'Desc_EN',      limit: 255
    t.string   'Group_N',      limit: 30
    t.integer  'ctrl_power',   limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.string   'nom_state',    limit: 32
    t.float    'low_lim',      limit: 53
    t.float    'up_lim',       limit: 53
    t.float    'LA',           limit: 53
    t.float    'HA',           limit: 53
    t.float    'LW',           limit: 53
    t.float    'HW',           limit: 53
    t.float    'LT',           limit: 53
    t.float    'HT',           limit: 53
    t.integer  'Unit',         limit: 4, index: { name: 'Unit', using: :btree }
    t.float    '1coef_shift',  limit: 53
    t.float    '2coef_scale',  limit: 53
    t.float    'sluggishness', limit: 53
    t.float    'scale_noise',  limit: 53
    t.integer  'sd_N',         limit: 4, index: { name: 'sd_N', using: :btree }
    t.integer  'doc_reg_N',    limit: 4, index: { name: 'doc_reg_N', using: :btree }
    t.string   'Func',         limit: 1000
    t.datetime 't',            null: false
    t.string   'Type',         limit: 2, default: 'AI'
    t.string   'TypeDetec',    limit: 20
    t.string   'Room',         limit: 155
    t.string   'SPTable',      limit: 350
    t.string   'SCK_input',    limit: 20
    t.string   'SP_1',         limit: 64
    t.string   'SP_2',         limit: 64
    t.string   'SP_3',         limit: 64
    t.string   'SPT_ACTION',   limit: 150
    t.string   'SPT_COMMENT',  limit: 100
    t.string   'DREG_input',   limit: 10
    t.integer  'TimeConst',    limit: 4
    t.integer  'power',        limit: 1, default: 0
    t.string   'varible',      limit: 255
    t.datetime 'import_t'
    t.string   'mod',          limit: 255
    t.integer  'eq_type',      limit: 4, index: { name: 'FK_pds_detectors_eq_type1', using: :btree }
    t.string   'alg_type',     limit: 16
  end
  add_index 'pds_detectors', ['DetID'], name: 'DetID', unique: true, using: :btree

  create_table 'pds_doc_on_sys', primary_key: 'DocSysID', force: :cascade do |t|
    t.integer  'Doc', limit: 4, null: false, index: { name: 'Doc', using: :btree }
    t.integer  'sys', limit: 4, index: { name: 'Sys', using: :btree }
    t.datetime 't',   null: false
  end
  add_index 'pds_doc_on_sys', ['DocSysID'], name: 'DocSysID', unique: true, using: :btree

  create_table 'pds_documentation', primary_key: 'DocID', force: :cascade do |t|
    t.integer  'Project',      limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'Type',         limit: 255
    t.string   'NPP_Number',   limit: 255
    t.string   'Revision',     limit: 50
    t.string   'reg_ID',       limit: 255, default: ''
    t.date     'getting_date'
    t.text     'DocTitle',     limit: 65_535
    t.text     'DocTitle_EN',  limit: 65_535
    t.boolean  'Hardcopy',     default: false
    t.string   'File',         limit: 255, index: { name: 'DocObject', using: :btree }
    t.datetime 't',            null: false
  end
  add_index 'pds_documentation', ['DocID'], name: 'DocID', unique: true, using: :btree

  create_table 'pds_documents', primary_key: 'docID', force: :cascade do |t|
    t.string   'DocTitle',   limit: 255, null: false
    t.string   'Code',       limit: 63
    t.integer  'Author',     limit: 4, index: { name: 'Author', using: :btree }
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'FileRu',     limit: 255
    t.string   'FileEn',     limit: 255
    t.integer  'CheckOutRu', limit: 4, index: { name: 'CheckOut', using: :btree }
    t.datetime 't',          null: false
    t.integer  'CheckOutEn', limit: 4, index: { name: 'CheckOutEn', using: :btree }
  end
  add_index 'pds_documents', ['docID'], name: 'docID', unique: true, using: :btree

  create_table 'pds_dr', primary_key: 'drID', force: :cascade do |t|
    t.integer  'sys',              limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project',          limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'drNum',            limit: 4, null: false
    t.string   'stage',            limit: 32
    t.string   'drAuthor_text',    limit: 32
    t.integer  'drAuthor',         limit: 4, index: { name: 'drAuthor', using: :btree }
    t.boolean  'rfr'
    t.boolean  'closed'
    t.datetime 'createDate'
    t.datetime 'expRespDate'
    t.text     'query',            limit: 65_535
    t.text     'reply',            limit: 65_535
    t.text     'sentForRev',       limit: 65_535
    t.string   'replyAuthor_text', limit: 32
    t.integer  'replyAuthor',      limit: 4, index: { name: 'NewIndex1', using: :btree }
    t.integer  'closedBy',         limit: 4, index: { name: 'NewIndex2', using: :btree }
    t.datetime 'openedDate'
    t.datetime 'inprogressDate'
    t.datetime 'replyDate'
    t.datetime 'closedDate'
    t.string   'NameDr',           limit: 64
    t.string   'Status',           limit: 17
    t.integer  'IC',               limit: 4
    t.string   'PowerState',       limit: 32
    t.string   'Priority',         limit: 16
    t.string   'Disparity',        limit: 1024
    t.string   'CommingResult',    limit: 1024
  end
  add_index 'pds_dr', %w(Project drNum), name: 'UniqueDrnum', unique: true, using: :btree
  add_index 'pds_dr', ['drID'], name: 'drID', unique: true, using: :btree

  create_table 'pds_dr_binobj', primary_key: 'objID', force: :cascade do |t|
    t.integer  'Project', limit: 4, null: false
    t.string   'Title',   limit: 255
    t.binary   'BinObj',  limit: 16_777_215
    t.integer  'drID',    limit: 4, null: false
    t.string   'Type',    limit: 16
    t.integer  'Length',  limit: 4
    t.datetime 't'
  end

  create_table 'pds_dr_stats', primary_key: 'hist_id', force: :cascade do |t|
    t.integer  'Project',     limit: 4, null: false, index: { name: 'FK_pds_dr_stats', using: :btree }
    t.integer  'sys_id',      limit: 4, null: false, index: { name: 'FK_pds_dr_stats_sys', using: :btree }
    t.integer  'opened',      limit: 4, default: 0, null: false
    t.integer  'closed',      limit: 4, default: 0, null: false
    t.integer  'in_progress', limit: 4, default: 0, null: false
    t.integer  'rfr',         limit: 4, default: 0, null: false
    t.integer  'overdue',     limit: 4
    t.datetime 'date_stamp',  null: false
  end

  create_table 'pds_ejector', primary_key: 'ejectorID', force: :cascade do |t|
    t.string  'kks',       limit: 15, null: false
    t.string  'ShortDesc', limit: 80
    t.text    'Desc_EN',   limit: 65_535
    t.float   'capacity',  limit: 24
    t.float   'level',     limit: 24
    t.string  'room',      limit: 15
    t.integer 'Project',   limit: 4, null: false, index: { name: 'FK_pds_ejector1', using: :btree }
    t.integer 'sys',       limit: 4, index: { name: 'FK_pds_ejector_sys1', using: :btree }
    t.integer 'eq_type',   limit: 4, index: { name: 'FK_pds_ejector_eq_type1', using: :btree }
    t.integer 'Unit',      limit: 4, index: { name: 'FK_pds_ejector_unit1', using: :btree }
    t.integer 'sd_N',      limit: 4, index: { name: 'sd_N', using: :btree }
  end

  create_table 'pds_eng_on_sys', primary_key: 'AssignID', force: :cascade do |t|
    t.integer  'sys',            limit: 4, null: false, index: { name: 'System', using: :btree }
    t.integer  'Project',        limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'engineer_N',     limit: 4, null: false, index: { name: 'engineer_N', using: :btree }
    t.datetime 't',              null: false
    t.integer  'TestOperator_N', limit: 4, index: { name: 'TestOperator_N', using: :btree }
  end
  add_index 'pds_eng_on_sys', ['AssignID'], name: 'AssignID', unique: true, using: :btree

  create_table 'pds_engineers', primary_key: 'engineer_N', force: :cascade do |t|
    t.string   'name',                limit: 50, null: false
    t.string   'TH',                  limit: 1, default: '0'
    t.boolean  'TO',                  default: false
    t.boolean  'L',                   default: false
    t.boolean  'EL',                  default: false
    t.boolean  'CR',                  default: false
    t.boolean  'D',                   default: false
    t.boolean  'SWM',                 default: false
    t.boolean  'HWM',                 default: false
    t.boolean  'PM',                  default: false
    t.datetime 't',                   null: false
    t.string   'EMail',               limit: 30
    t.boolean  'CheifDirector',       default: false
    t.string   'login',               limit: 50
    t.string   'pwd',                 limit: 40
    t.boolean  'dismiss',             default: false
    t.integer  'coreID',              limit: 4, index: { name: 'coreID', using: :btree }
    t.string   'phoneNum',            limit: 11
    t.string   'cellNum',             limit: 32
    t.string   'IP',                  limit: 16
    t.integer  'compJack',            limit: 4
    t.integer  'phoneJack',           limit: 4
    t.integer  'sectorID1',           limit: 4
    t.boolean  'enabled',             default: true, null: false
    t.string   'encrypted_password',  limit: 255, default: '', null: false
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count', limit: 4, default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string   'current_sign_in_ip',  limit: 255
    t.string   'last_sign_in_ip',     limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end
  add_index 'pds_engineers', ['engineer_N'], name: 'engineer_N', unique: true, using: :btree

  create_table 'pds_equipments', primary_key: 'EqID', force: :cascade do |t|
    t.integer 'Project',        limit: 4, null: false, index: { name: 'FK_pds_equipments1', using: :btree }
    t.integer 'sys',            limit: 4, index: { name: 'fk_sys', using: :btree }
    t.string  'KKS',            limit: 32
    t.integer 'eq_type',        limit: 4, index: { name: 'fk_eq_type', using: :btree }
    t.string  'Description_RU', limit: 100
    t.string  'Description_EN', limit: 100
    t.integer 'type_equip',     limit: 4, null: false, index: { name: 'fk_type', using: :btree }
    t.integer 'sd_N',           limit: 4, index: { name: 'sd_N', using: :btree }
  end
  add_index 'pds_equipments', ['EqID'], name: 'EqID', unique: true, using: :btree

  create_table 'pds_equips', primary_key: 'TEquipID', force: :cascade do |t|
    t.string 'typeE', limit: 50, null: false
  end
  add_index 'pds_equips', ['TEquipID'], name: 'TEquipID', unique: true, using: :btree

  create_table 'pds_filter', primary_key: 'filterID', force: :cascade do |t|
    t.string  'kks',       limit: 15, null: false
    t.string  'ShortDesc', limit: 80
    t.text    'Desc_EN',   limit: 65_535
    t.float   'level',     limit: 24
    t.string  'room',      limit: 32
    t.integer 'Project',   limit: 4, null: false, index: { name: 'FK_pds_filter', using: :btree }
    t.integer 'sys',       limit: 4, index: { name: 'FK_pds_filter_sys', using: :btree }
    t.integer 'eq_type',   limit: 4, index: { name: 'FK_pds_filter_eq_type', using: :btree }
    t.string  'var',       limit: 64
    t.string  'old_var',   limit: 64
    t.integer 'sd_N',      limit: 4, index: { name: 'sd_N', using: :btree }
  end

  create_table 'pds_hex', primary_key: 'hexID', force: :cascade do |t|
    t.string  'kks',       limit: 15, null: false
    t.string  'ShortDesc', limit: 80
    t.float   's',         limit: 24
    t.float   'level',     limit: 24
    t.string  'room',      limit: 15
    t.integer 'Project',   limit: 4, null: false, index: { name: 'FK_pds_hex', using: :btree }
    t.integer 'sys',       limit: 4, index: { name: 'FK_pds_hex_sys', using: :btree }
    t.integer 'eq_type',   limit: 4, index: { name: 'FK_pds_hex_eq_type', using: :btree }
    t.string  'var',       limit: 64
    t.string  'old_var',   limit: 64
    t.text    'Desc_EN',   limit: 65_535
    t.integer 'sd_N',      limit: 4, index: { name: 'sd_N', using: :btree }
  end

  create_table 'pds_iomap', primary_key: 'hwaddress_N', force: :cascade do |t|
    t.integer  'Project',              limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'hwaddress',            limit: 20, null: false, index: { name: 'hwaddress', unique: true, using: :btree }
    t.string   'io_point_name',        limit: 15
    t.integer  'number_of_array_elem', limit: 4
    t.integer  'sid',                  limit: 4, index: { name: 'sid_N', using: :btree }
    t.string   'comp_name',            limit: 20
    t.string   'remark',               limit: 20
    t.datetime 't',                    null: false
  end
  add_index 'pds_iomap', ['hwaddress_N'], name: 'hwaddress_N', unique: true, using: :btree

  create_table 'pds_lamps', primary_key: 'LampID', force: :cascade do |t|
    t.integer  'IC',         limit: 4, index: { name: 'IC', using: :btree }
    t.integer  'sys',        limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'ctrl_power', limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.datetime 't',          null: false
  end
  add_index 'pds_lamps', ['LampID'], name: 'LampID', unique: true, using: :btree

  create_table 'pds_malfunction', primary_key: 'MalfID', force: :cascade do |t|
    t.integer  'sys',              limit: 4, null: false, index: { name: 'sys', using: :btree }
    t.integer  'Dimension',        limit: 2, default: 1, null: false
    t.integer  'Project',          limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'Numb',             limit: 2, null: false
    t.text     'shortDesc',        limit: 65_535, null: false
    t.text     'shortDesc_EN',     limit: 65_535
    t.text     'cause',            limit: 65_535, null: false
    t.text     'cause_EN',         limit: 65_535
    t.text     'fullDesc',         limit: 16_777_215, null: false
    t.text     'fullDesc_EN',      limit: 16_777_215
    t.string   'type',             limit: 3, default: ''
    t.text     'if_delete',        limit: 16_777_215
    t.string   'if_delete_EN',     limit: 255
    t.float    'lowlim_regidity',  limit: 53
    t.float    'uplim_regidity',   limit: 53
    t.string   'regidity_unit',    limit: 5, default: 'dmnls'
    t.string   'regidity_text',    limit: 255
    t.string   'regidity_text_EN', limit: 255
    t.string   'Unit_status',      limit: 255
    t.datetime 't',                null: false
    t.string   'File',             limit: 255, index: { name: 'BlobObj', using: :btree }
    t.integer  'regidity_unitid',  limit: 4, index: { name: 'regidity_unitid', using: :btree }
    t.integer  'scale',            limit: 1
    t.integer  'sd_N',             limit: 4, index: { name: 'FK_pds_malfunction', using: :btree }
  end
  add_index 'pds_malfunction', ['MalfID'], name: 'MalfID', unique: true, using: :btree

  create_table 'pds_malfunction_dim', primary_key: 'MalfunctDimID', force: :cascade do |t|
    t.integer 'Project',     limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer 'Malfunction', limit: 4, null: false, index: { name: 'Malfunction', using: :btree }
    t.string  'Character',   limit: 15
    t.string  'Target_EN',   limit: 255
    t.string  'Target',      limit: 255
    t.integer 'sd_N',        limit: 4, index: { name: 'sd_N', using: :btree }
    t.boolean 'is_main',     default: false
  end
  add_index 'pds_malfunction_dim', ['MalfunctDimID'], name: 'MalfunctDimID', unique: true, using: :btree

  create_table 'pds_man_equip', primary_key: 'EquipN', force: :cascade do |t|
    t.string   'Type',       limit: 3, null: false, index: { name: 'Type', unique: true, using: :btree }
    t.string   'Descriptor', limit: 100
    t.string   'Contr_win',  limit: 1, null: false
    t.string   'Over_menu',  limit: 1, null: false
    t.string   'Comp_malf',  limit: 3, default: '-'
    t.datetime 't',          null: false
  end
  add_index 'pds_man_equip', ['EquipN'], name: 'EquipN', unique: true, using: :btree

  create_table 'pds_mathmodel', primary_key: 'mm_id', force: :cascade do |t|
    t.integer 'Project', limit: 4, null: false, index: { name: 'FK_pds_mathmodel_prj', using: :btree }
    t.integer 'sys',     limit: 4, index: { name: 'FK_pds_mathmodel_sys', using: :btree }
    t.integer 'task_N',  limit: 4
    t.text    'Desc_RU', limit: 65_535
    t.text    'Desc_EN', limit: 65_535
  end

  create_table 'pds_meters', primary_key: 'MetID', force: :cascade do |t|
    t.integer  'IC',         limit: 4, null: false, index: { name: 'IC', using: :btree }
    t.integer  'sys',        limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'ctrl_power', limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.datetime 't',          null: false
  end
  add_index 'pds_meters', ['MetID'], name: 'MetID', unique: true, using: :btree

  create_table 'pds_meters_channels', primary_key: 'MetChanID', force: :cascade do |t|
    t.integer  'IC',         limit: 4, null: false, index: { name: 'IC', using: :btree }
    t.integer  'sys',        limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'ctrl_power', limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.datetime 't',          null: false
  end
  add_index 'pds_meters_channels', ['MetChanID'], name: 'MetChanID', unique: true, using: :btree

  create_table 'pds_meters_digital', primary_key: 'MetDigID', force: :cascade do |t|
    t.integer  'IC',         limit: 4, null: false, index: { name: 'IC', using: :btree }
    t.integer  'sys',        limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'ctrl_power', limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.datetime 't',          null: false
  end
  add_index 'pds_meters_digital', ['MetDigID'], name: 'MetDigID', unique: true, using: :btree

  create_table 'pds_misc', primary_key: 'MiscID', force: :cascade do |t|
    t.integer  'IC',         limit: 4, null: false, index: { name: 'IC', using: :btree }
    t.integer  'sys',        limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'ctrl_power', limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.datetime 't',          null: false
  end
  add_index 'pds_misc', ['MiscID'], name: 'MiscID', unique: true, using: :btree

  create_table 'pds_mnemo', primary_key: 'MnemoID', force: :cascade do |t|
    t.integer 'sys',             limit: 4, index: { name: 'sys', using: :btree }
    t.integer 'Project',         limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string  'Code',            limit: 50, null: false
    t.string  'Marker',          limit: 50
    t.string  'TechCode',        limit: 50
    t.string  'Type',            limit: 50
    t.string  'Opened',          limit: 50
    t.string  'Closed',          limit: 50
    t.string  'Control',         limit: 50
    t.string  'AutoDist',        limit: 50
    t.string  'Parameter',       limit: 50
    t.string  'Description',     limit: 1000
    t.string  'Description_EN',  limit: 255
    t.string  'Gr_Dreg',         limit: 50
    t.integer 'Detector',        limit: 4, index: { name: 'Detector', using: :btree }
    t.string  'Characteristics', limit: 50
  end

  create_table 'pds_motor_type', primary_key: 'MotorTypeID', force: :cascade do |t|
    t.string   'MotorType',      limit: 255
    t.float    'I_nom',          limit: 53
    t.float    'U_nom',          limit: 53
    t.float    'nom_pressure',   limit: 53
    t.float    'nom_water_rate', limit: 53
    t.float    'N_nom',          limit: 53
    t.float    'cos',            limit: 53
    t.float    'up_rate',        limit: 53
    t.float    'down_rate',      limit: 53
    t.float    'Coeff1',         limit: 53
    t.float    'Coeff2',         limit: 53
    t.float    'Coeff3',         limit: 53
    t.datetime 't',              null: false
  end
  add_index 'pds_motor_type', ['MotorTypeID'], name: 'MotorTypeID', unique: true, using: :btree

  create_table 'pds_motors', primary_key: 'MotID', force: :cascade do |t|
    t.integer  'Project',        limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'MotorType',      limit: 4, index: { name: 'MotorType', using: :btree }
    t.integer  'sys',            limit: 4, index: { name: 'sys', using: :btree }
    t.string   'station_sys',    limit: 120
    t.string   'tag_RU',         limit: 50
    t.string   'tag_EN',         limit: 50
    t.string   'Desc_RU',        limit: 255
    t.string   'Desc_EN',        limit: 255
    t.integer  'ed_power',       limit: 4, index: { name: 'ed_power', using: :btree }
    t.integer  'ctrl_power',     limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.integer  'anc_power',      limit: 4, index: { name: 'anc_power', using: :btree }
    t.string   'room',           limit: 32
    t.string   'elevation',      limit: 32
    t.integer  'Stopway',        limit: 4
    t.boolean  'nom_state',      default: false
    t.float    'lim_power',      limit: 53
    t.float    'effeciency',     limit: 53
    t.float    'rotation_speed', limit: 53
    t.integer  'sd_N',           limit: 4, index: { name: 'sd_N', using: :btree }
    t.integer  'doc_reg_N',      limit: 4, index: { name: 'doc_reg_N', using: :btree }
    t.datetime 't',              null: false
    t.float    'up_rate',        limit: 53
    t.float    'down_rate',      limit: 53
    t.string   'zmn',            limit: 14
    t.string   'model',          limit: 64
    t.string   'type_temp',      limit: 32
    t.float    'voltage',        limit: 24
    t.string   'RTZO_OLD1',      limit: 16
    t.string   'RTZO_OLD2',      limit: 16
    t.string   'RTZO_NEW1',      limit: 16
    t.string   'RTZO_NEW2',      limit: 16
    t.decimal  'p_ust',          precision: 15, scale: 3
    t.decimal  'i_nom',          precision: 7, scale: 1
    t.datetime 'import_t'
    t.string   'mod',            limit: 255
    t.integer  'eq_type',        limit: 4, index: { name: 'FK_pds_motors_eq_type', using: :btree }
    t.string   'connection',     limit: 16
    t.string   'Algorithm',      limit: 80
    t.integer  'power_section',  limit: 4, index: { name: 'power_section', using: :btree }
  end
  add_index 'pds_motors', ['MotID'], name: 'MotID', unique: true, using: :btree

  create_table 'pds_motors_59', id: false, force: :cascade do |t|
    t.datetime 't',              null: false
    t.string   'mod',            limit: 255
    t.datetime 'import_t'
    t.integer  'MotID',          limit: 4, default: 0, null: false
    t.string   'model',          limit: 64
    t.integer  'MotorTypeID',    limit: 4
    t.string   'MotorType',      limit: 255
    t.float    'up_rate',        limit: 53
    t.float    'down_rate',      limit: 53
    t.integer  'SystemID',       limit: 4
    t.string   'sys',            limit: 8, default: ''
    t.string   'station_sys',    limit: 120
    t.string   'tag_RU',         limit: 50
    t.string   'tag_EN',         limit: 50
    t.string   'Desc_RU',        limit: 255
    t.string   'Desc_EN',        limit: 255
    t.integer  'ed_powerID',     limit: 4
    t.string   'type_temp',      limit: 32
    t.float    'voltage',        limit: 24
    t.string   'RTZO_OLD1',      limit: 16
    t.string   'RTZO_OLD2',      limit: 16
    t.string   'RTZO_NEW1',      limit: 16
    t.string   'RTZO_NEW2',      limit: 16
    t.string   'ed_power',       limit: 32
    t.integer  'ctrl_powerID',   limit: 4
    t.string   'ctrl_power',     limit: 32
    t.integer  'anc_powerID',    limit: 4
    t.string   'anc_power',      limit: 32
    t.string   'elevation',      limit: 32
    t.integer  'Stopway',        limit: 4
    t.boolean  'nom_state',      default: false
    t.float    'lim_power',      limit: 53
    t.float    'effeciency',     limit: 53
    t.float    'rotation_speed', limit: 53
    t.string   'zmn',            limit: 14
    t.integer  'sd',             limit: 4
    t.string   'connection',     limit: 16
    t.decimal  'i_nom',          precision: 7, scale: 1
    t.decimal  'p_ust',          precision: 15, scale: 3
  end

  create_table 'pds_motors_60', id: false, force: :cascade do |t|
    t.datetime 't',              null: false
    t.string   'mod',            limit: 255
    t.datetime 'import_t'
    t.integer  'MotID',          limit: 4, default: 0, null: false
    t.string   'model',          limit: 64
    t.integer  'MotorTypeID',    limit: 4
    t.string   'MotorType',      limit: 255
    t.float    'up_rate',        limit: 53
    t.float    'down_rate',      limit: 53
    t.integer  'SystemID',       limit: 4
    t.string   'sys',            limit: 8, default: ''
    t.string   'station_sys',    limit: 120
    t.string   'tag_RU',         limit: 50
    t.string   'tag_EN',         limit: 50
    t.string   'Desc_RU',        limit: 255
    t.string   'Desc_EN',        limit: 255
    t.integer  'ed_powerID',     limit: 4
    t.string   'type_temp',      limit: 32
    t.float    'voltage',        limit: 24
    t.string   'RTZO_OLD1',      limit: 16
    t.string   'RTZO_OLD2',      limit: 16
    t.string   'RTZO_NEW1',      limit: 16
    t.string   'RTZO_NEW2',      limit: 16
    t.string   'ed_power',       limit: 32
    t.integer  'ctrl_powerID',   limit: 4
    t.string   'ctrl_power',     limit: 32
    t.integer  'anc_powerID',    limit: 4
    t.string   'anc_power',      limit: 32
    t.string   'elevation',      limit: 32
    t.integer  'Stopway',        limit: 4
    t.boolean  'nom_state',      default: false
    t.float    'lim_power',      limit: 53
    t.float    'effeciency',     limit: 53
    t.float    'rotation_speed', limit: 53
    t.string   'zmn',            limit: 14
    t.integer  'sd',             limit: 4
    t.string   'connection',     limit: 16
    t.decimal  'i_nom',          precision: 7, scale: 1
    t.decimal  'p_ust',          precision: 15, scale: 3
    t.string   'eq_type',        limit: 3
  end

  create_table 'pds_motors_62', id: false, force: :cascade do |t|
    t.datetime 't',              null: false
    t.string   'mod',            limit: 255
    t.datetime 'import_t'
    t.integer  'MotID',          limit: 4, default: 0, null: false
    t.string   'model',          limit: 64
    t.integer  'MotorTypeID',    limit: 4
    t.string   'MotorType',      limit: 255
    t.float    'up_rate',        limit: 53
    t.float    'down_rate',      limit: 53
    t.integer  'SystemID',       limit: 4
    t.string   'sys',            limit: 8, default: ''
    t.string   'station_sys',    limit: 120
    t.string   'tag_RU',         limit: 50
    t.string   'tag_EN',         limit: 50
    t.string   'Desc_RU',        limit: 255
    t.string   'Desc_EN',        limit: 255
    t.integer  'ed_powerID',     limit: 4
    t.string   'type_temp',      limit: 32
    t.float    'voltage',        limit: 24
    t.string   'RTZO_OLD1',      limit: 16
    t.string   'RTZO_OLD2',      limit: 16
    t.string   'RTZO_NEW1',      limit: 16
    t.string   'RTZO_NEW2',      limit: 16
    t.string   'ed_power',       limit: 32
    t.integer  'ctrl_powerID',   limit: 4
    t.string   'ctrl_power',     limit: 32
    t.integer  'anc_powerID',    limit: 4
    t.string   'anc_power',      limit: 32
    t.string   'elevation',      limit: 32
    t.integer  'Stopway',        limit: 4
    t.boolean  'nom_state',      default: false
    t.float    'lim_power',      limit: 53
    t.float    'effeciency',     limit: 53
    t.float    'rotation_speed', limit: 53
    t.string   'zmn',            limit: 14
    t.integer  'sd',             limit: 4
    t.string   'connection',     limit: 16
    t.decimal  'i_nom',          precision: 7, scale: 1
    t.decimal  'p_ust',          precision: 15, scale: 3
    t.string   'eq_type',        limit: 3
  end

  create_table 'pds_motors_73', id: false, force: :cascade do |t|
    t.datetime 't',              null: false
    t.string   'mod',            limit: 255
    t.datetime 'import_t'
    t.integer  'MotID',          limit: 4, default: 0, null: false
    t.string   'model',          limit: 64
    t.integer  'MotorTypeID',    limit: 4
    t.string   'MotorType',      limit: 255
    t.float    'up_rate',        limit: 53
    t.float    'down_rate',      limit: 53
    t.integer  'SystemID',       limit: 4
    t.string   'sys',            limit: 8, default: ''
    t.string   'station_sys',    limit: 120
    t.string   'tag_RU',         limit: 50
    t.string   'tag_EN',         limit: 50
    t.string   'Desc_RU',        limit: 255
    t.string   'Desc_EN',        limit: 255
    t.integer  'ed_powerID',     limit: 4
    t.string   'type_temp',      limit: 32
    t.float    'voltage',        limit: 24
    t.string   'RTZO_OLD1',      limit: 16
    t.string   'RTZO_OLD2',      limit: 16
    t.string   'RTZO_NEW1',      limit: 16
    t.string   'RTZO_NEW2',      limit: 16
    t.string   'ed_power',       limit: 32
    t.integer  'ctrl_powerID',   limit: 4
    t.string   'ctrl_power',     limit: 32
    t.integer  'anc_powerID',    limit: 4
    t.string   'anc_power',      limit: 32
    t.string   'elevation',      limit: 32
    t.integer  'Stopway',        limit: 4
    t.boolean  'nom_state',      default: false
    t.float    'lim_power',      limit: 53
    t.float    'effeciency',     limit: 53
    t.float    'rotation_speed', limit: 53
    t.string   'zmn',            limit: 14
    t.integer  'sd',             limit: 4
    t.string   'connection',     limit: 16
    t.decimal  'i_nom',          precision: 7, scale: 1
    t.decimal  'p_ust',          precision: 15, scale: 3
    t.string   'eq_type',        limit: 3
  end

  create_table 'pds_negotiators', primary_key: 'nID', force: :cascade do |t|
    t.string  'name',    limit: 128
    t.string  'post',    limit: 256
    t.integer 'Project', limit: 4, null: false
    t.boolean 'chef'
    t.integer 'ord', limit: 4
  end

  create_table 'pds_panel', primary_key: 'pID', force: :cascade do |t|
    t.string  'panel',           limit: 32
    t.string  'start',           limit: 15
    t.string  'end',             limit: 15
    t.integer 'migsjem',         limit: 4, index: { name: 'migsjem', using: :btree }
    t.integer 'memsjem',         limit: 4, index: { name: 'memsjem', using: :btree }
    t.integer 'lamptest',        limit: 4, index: { name: 'lamptest', using: :btree }
    t.integer 'soundtest',       limit: 4, index: { name: 'soundtest', using: :btree }
    t.integer 'soundtest_warn',  limit: 4, index: { name: 'soundtest_warn', using: :btree }
    t.integer 'pressconfirm',    limit: 4, index: { name: 'pressconfirm', using: :btree }
    t.integer 'soundtest_alarm', limit: 4, index: { name: 'soundtest_alarm', using: :btree }
    t.integer 'Project',         limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer 'soundsjem',       limit: 4, index: { name: 'soundsjem', using: :btree }
    t.integer 'soundalarm',      limit: 4
    t.string  'power_lamp',      limit: 63
    t.integer 'Tab_No',          limit: 4
    t.string  'pnl_type',        limit: 3
    t.string  'fhd',             limit: 16, default: 'fhd'
    t.string  'lamptest_suff',   limit: 16
    t.integer 'lo_cnt',          limit: 4
  end
  add_index 'pds_panel', ['pID'], name: 'pID', unique: true, using: :btree

  create_table 'pds_ppca', primary_key: 'ppcID', force: :cascade do |t|
    t.integer  'Project',        limit: 4, null: false, index: { name: 'ProjectID', using: :btree }
    t.integer  'sys',            limit: 4, index: { name: 'sys', using: :btree }
    t.string   'Shifr',          limit: 50, index: { name: 'NewIndex1', using: :btree }
    t.string   'Key',            limit: 50
    t.string   'identif',        limit: 50
    t.text     'Description',    limit: 65_535
    t.text     'Description_EN', limit: 65_535
    t.integer  'Detector',       limit: 4, index: { name: 'detector', using: :btree }
    t.string   'Unit',           limit: 50
    t.float    'L_lim',          limit: 53
    t.float    'U_lim',          limit: 53
    t.string   'nom',            limit: 16
    t.float    'LA',             limit: 53
    t.float    'LW',             limit: 53
    t.float    'HW',             limit: 53
    t.float    'HA',             limit: 53
    t.datetime 't',              null: false
    t.string   'code',           limit: 255
    t.integer  'power',          limit: 1, default: 0
    t.integer  'UnitID',         limit: 4, index: { name: 'UnitID', using: :btree }
  end
  add_index 'pds_ppca', ['ppcID'], name: 'ppcID', unique: true, using: :btree

  create_table 'pds_ppcd', primary_key: 'ppcdID', force: :cascade do |t|
    t.integer  'Project',        limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'sys',            limit: 4, index: { name: 'sys', using: :btree }
    t.string   'Shifr',          limit: 150
    t.string   'Key',            limit: 50
    t.string   'identif',        limit: 50
    t.text     'Description',    limit: 65_535
    t.text     'Description_EN', limit: 65_535
    t.integer  'Detector',       limit: 4, index: { name: 'detector', using: :btree }
    t.datetime 't',              null: false
    t.string   'code',           limit: 255
  end

  create_table 'pds_project', primary_key: 'ProjectID', force: :cascade do |t|
    t.string   'project_number',    limit: 50, null: false, index: { name: 'project_number', with: ['project_name'], unique: true, using: :btree }
    t.string   'project_name',      limit: 50, null: false
    t.string   'project_name_EN',   limit: 255
    t.string   'Contractor',        limit: 255, null: false
    t.integer  'companyID',         limit: 4, index: { name: 'fk_company', using: :btree }
    t.string   'contract_number',   limit: 64, default: ''
    t.date     'contract_date'
    t.integer  'ProjectManager',    limit: 4, index: { name: 'ProjectManager', using: :btree }
    t.integer  'SWManager',         limit: 4, index: { name: 'SWManager', using: :btree }
    t.integer  'HWManager',         limit: 4, index: { name: 'HWManager', using: :btree }
    t.string   'Factor',            limit: 50
    t.string   'Description',       limit: 1000
    t.text     'Description_EN',    limit: 65_535
    t.string   'Notes',             limit: 1000
    t.integer  'BlobObj',           limit: 4, index: { name: 'Logo', using: :btree }
    t.datetime 't',                 null: false
    t.date     'contract_end_date'
  end
  add_index 'pds_project', ['ProjectID'], name: 'ProjectID', unique: true, using: :btree

  create_table 'pds_project_properties', primary_key: 'ProjectID', force: :cascade do |t|
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
    t.integer 'LowLimKeyField', limit: 4
    t.integer 'UpLimKeyField',  limit: 4
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
  end
  add_index 'pds_project_properties', ['ProjectID'], name: 'ProjectID', unique: true, using: :btree

  create_table 'pds_project_sys', primary_key: 'StationID', force: :cascade do |t|
    t.integer  'Project',     limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'Station_sys', limit: 15, null: false
    t.integer  'sys',         limit: 4, index: { name: 'sys', using: :btree }
    t.string   'Desc_RU',     limit: 255
    t.string   'Desc_EN',     limit: 255
    t.datetime 't',           null: false
  end
  add_index 'pds_project_sys', ['StationID'], name: 'StationID', unique: true, using: :btree

  create_table 'pds_project_unit', primary_key: 'ProjUnitID', force: :cascade do |t|
    t.integer  'Project', limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'Unit',    limit: 4, null: false, index: { name: 'Unit', using: :btree }
    t.datetime 't',       null: false
  end
  add_index 'pds_project_unit', ['ProjUnitID'], name: 'ProjUnitID', unique: true, using: :btree

  create_table 'pds_queries', primary_key: 'queryID', force: :cascade do |t|
    t.integer  'Project',              limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'sys',                  limit: 4, null: false, index: { name: 'sys', using: :btree }
    t.string   'queryNumber',          limit: 15, null: false
    t.date     'query_make_date',      null: false
    t.date     'answer_expected_date', null: false
    t.text     'query_essence',        limit: 65_535, null: false
    t.integer  'engineer_N',           limit: 4, null: false, index: { name: 'engineer_N', using: :btree }
    t.date     'query_transfer_date'
    t.date     'answer_date'
    t.text     'answer_essence',       limit: 65_535
    t.string   'who_answered',         limit: 50, index: { name: 'who_answered', using: :btree }
    t.boolean  'if_close',             default: false
    t.text     'Assumption',           limit: 65_535
    t.datetime 't',                    null: false
  end

  create_table 'pds_recorders', primary_key: 'RecID', force: :cascade do |t|
    t.integer  'IC',         limit: 4, null: false, index: { name: 'IC', using: :btree }
    t.integer  'sys',        limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'ctrl_power', limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.datetime 't',          null: false
  end
  add_index 'pds_recorders', ['RecID'], name: 'RecID', unique: true, using: :btree

  create_table 'pds_regulators', primary_key: 'RegID', force: :cascade do |t|
    t.string   'model',       limit: 64
    t.integer  'Project',     limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'sys',         limit: 4, index: { name: 'sys', using: :btree }
    t.string   'tag_RU',      limit: 32
    t.string   'tag_EN',      limit: 32
    t.string   'station_sys', limit: 64
    t.string   'Desc',        limit: 100, null: false
    t.integer  'ed_power',    limit: 4, index: { name: 'ed_power', using: :btree }
    t.integer  'ctrl_power',  limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.integer  'anc_power',   limit: 4, index: { name: 'anc_power', using: :btree }
    t.float    'nom_state',   limit: 53
    t.float    'open_rate',   limit: 53
    t.float    'close_rate',  limit: 53
    t.integer  'sd_N',        limit: 4, index: { name: 'sd_N', using: :btree }
    t.integer  'doc_reg_N',   limit: 4, index: { name: 'doc_reg_N', using: :btree }
    t.string   'Algorithm',   limit: 64
    t.datetime 't',           null: false
    t.string   'Desc_EN',     limit: 100, default: ''
    t.datetime 'import_t'
    t.string   'mod',         limit: 255
    t.string   'vlv',         limit: 127
    t.integer  'vlv_1',       limit: 4, index: { name: 'FK_pds_regulators', using: :btree }
    t.integer  'vlv_2',       limit: 4, index: { name: 'FK_pds_regulators_2', using: :btree }
    t.integer  'det_id',      limit: 4, index: { name: 'FK_pds_regulators_det_id', using: :btree }
    t.integer  'eq_type',     limit: 4, index: { name: 'FK_pds_regulators_eq_type', using: :btree }
    t.float    'par_val',     limit: 53
  end
  add_index 'pds_regulators', ['RegID'], name: 'RegID', unique: true, using: :btree

  create_table 'pds_rf', primary_key: 'rfID', force: :cascade do |t|
    t.integer  'sys',      limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project',  limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'name_RU',  limit: 32
    t.string   'name',     limit: 32, null: false
    t.string   'tag_RU',   limit: 32
    t.string   'Desc',     limit: 255, default: ''
    t.string   'Desc_EN',  limit: 255
    t.string   'range',    limit: 128, default: ''
    t.integer  'Unit',     limit: 4, index: { name: 'unit', using: :btree }
    t.string   'type',     limit: 2
    t.string   'Type_FB',  limit: 2
    t.integer  'unit_FB',  limit: 4, index: { name: 'unit_FB', using: :btree }
    t.string   'range_FB', limit: 128
    t.float    'rate',     limit: 53
    t.string   'Ptag',     limit: 30
    t.integer  'sd_N',     limit: 4, index: { name: 'sd_N', using: :btree }
    t.datetime 't',        null: false
    t.string   'typerf',   limit: 2
    t.string   'scale',    limit: 1
    t.integer  'frfID',    limit: 4, index: { name: 'FK_pds_rf', using: :btree }
  end
  add_index 'pds_rf', ['rfID'], name: 'rfID', unique: true, using: :btree

  create_table 'pds_sd', primary_key: 'sd_N', force: :cascade do |t|
    t.string   'SdTitle',     limit: 255, null: false
    t.integer  'sys',         limit: 4, null: false, index: { name: 'sys', using: :btree }
    t.integer  'Project',     limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'title_EN',    limit: 255
    t.string   'Numb',        limit: 3, null: false
    t.integer  'BlobObj',     limit: 4, index: { name: 'Image', using: :btree }
    t.datetime 't',           null: false
    t.datetime 'from_sapfir'
  end
  add_index 'pds_sd', ['sd_N'], name: 'sd_N', unique: true, using: :btree

  create_table 'pds_section_assembler', primary_key: 'section_N', force: :cascade do |t|
    t.integer  'Project',       limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'section_name',  limit: 32
    t.string   'assembler',     limit: 32
    t.datetime 't',             null: false
    t.string   'assembler_pwr', limit: 32
    t.string   'assembler_ec',  limit: 32
  end
  add_index 'pds_section_assembler', ['section_N'], name: 'section_N', unique: true, using: :btree

  create_table 'pds_set', primary_key: 'SetID', force: :cascade do |t|
    t.integer  'IC',      limit: 4, null: false, index: { name: 'IC', using: :btree }
    t.integer  'sys',     limit: 4, index: { name: 'sys', using: :btree }
    t.integer  'Project', limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.datetime 't',       null: false
  end
  add_index 'pds_set', ['SetID'], name: 'SetID', unique: true, using: :btree

  create_table 'pds_sids', primary_key: 'sid_N', force: :cascade do |t|
    t.integer  'Project',      limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'sid',          limit: 15, null: false, index: { name: 'sid', unique: true, using: :btree }
    t.integer  'trainer_code', limit: 4, index: { name: 'trainer_code_N', using: :btree }
    t.datetime 't',            null: false
  end
  add_index 'pds_sids', ['sid_N'], name: 'sid_N', unique: true, using: :btree

  create_table 'pds_simplifications', primary_key: 'SimplID', force: :cascade do |t|
    t.integer  'sys',        limit: 4, null: false, index: { name: 'sys', using: :btree }
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.string   'Numb',       limit: 3, null: false
    t.text     'Desc',       limit: 65_535, null: false
    t.text     'Desc_EN',    limit: 65_535
    t.text     'support',    limit: 65_535, null: false
    t.text     'support_EN', limit: 65_535
    t.integer  'queryID',    limit: 4, index: { name: 'query_N', using: :btree }
    t.datetime 't',          null: false
  end
  add_index 'pds_simplifications', ['SimplID'], name: 'SimplID', unique: true, using: :btree

  create_table 'pds_switch_fix', primary_key: 'KeyID', force: :cascade do |t|
    t.integer  'Project', limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'IC',      limit: 4, index: { name: 'IC', using: :btree }
    t.integer  'sys',     limit: 4, index: { name: 'sys', using: :btree }
    t.text     'range',   limit: 16_777_215
    t.datetime 't',       null: false
  end
  add_index 'pds_switch_fix', ['KeyID'], name: 'KeyID', unique: true, using: :btree

  create_table 'pds_switch_nofix', primary_key: 'KeyID', force: :cascade do |t|
    t.integer  'Project', limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'IC',      limit: 4, index: { name: 'IC', using: :btree }
    t.integer  'sys',     limit: 4, index: { name: 'sys', using: :btree }
    t.text     'range',   limit: 16_777_215
    t.datetime 't',       null: false
  end
  add_index 'pds_switch_nofix', ['KeyID'], name: 'KeyID', unique: true, using: :btree

  create_table 'pds_sys_description', primary_key: 'SysID', force: :cascade do |t|
    t.integer 'Project',        limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer 'sys',            limit: 4, null: false, index: { name: 'System', using: :btree }
    t.text    'Description',    limit: 4_294_967_295
    t.text    'Description_EN', limit: 4_294_967_295
    t.text    'shortDesc',      limit: 65_535
    t.text    'shortDesc_EN',   limit: 65_535
  end
  add_index 'pds_sys_description', %w(Project sys), name: 'Project_sys', unique: true, using: :btree
  add_index 'pds_sys_description', ['SysID'], name: 'SystemID', unique: true, using: :btree

  create_table 'pds_syslist', primary_key: 'SystemID', force: :cascade do |t|
    t.string   'System',       limit: 8, default: '', null: false, index: { name: 'System', unique: true, using: :btree }
    t.string   'Descriptor',   limit: 4
    t.string   'Category',     limit: 1
    t.text     'shortDesc',    limit: 65_535
    t.text     'shortDesc_EN', limit: 65_535
    t.datetime 't',            null: false
  end
  add_index 'pds_syslist', ['SystemID'], name: 'SystemID', unique: true, using: :btree

  create_table 'pds_unit', primary_key: 'UnitID', force: :cascade do |t|
    t.string   'Unit_RU',    limit: 15, null: false, index: { name: 'Unit_RU', unique: true, using: :btree }
    t.string   'Unit_EN',    limit: 15, null: false, index: { name: 'Unit_EN', unique: true, using: :btree }
    t.float    'MultFactor', limit: 53
    t.float    'ZeroShift',  limit: 53
    t.datetime 't',          null: false
    t.datetime 'import_t'
  end
  add_index 'pds_unit', ['UnitID'], name: 'UnitID', unique: true, using: :btree

  create_table 'pds_valves', primary_key: 'valveID', force: :cascade do |t|
    t.integer  'Project',       limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'sys',           limit: 4, index: { name: 'sys', using: :btree }
    t.string   'tag_RU',        limit: 255
    t.string   'tag_EN',        limit: 255
    t.string   'PowerTemp',     limit: 50
    t.string   'Type',          limit: 10
    t.string   'station_sys',   limit: 128
    t.string   'Desc',          limit: 255, default: '', null: false
    t.string   'Desc_EN',       limit: 255
    t.string   'Department',    limit: 10
    t.integer  'ed_power',      limit: 4, index: { name: 'ed_power', using: :btree }
    t.integer  'ctrl_power',    limit: 4, index: { name: 'ctrl_power', using: :btree }
    t.integer  'anc_power',     limit: 4, index: { name: 'anc_power', using: :btree }
    t.float    'nom_state',     limit: 53
    t.float    'open_rate',     limit: 53
    t.float    'close_rate',    limit: 53
    t.integer  'sd_N',          limit: 4, index: { name: 'sd_N', using: :btree }
    t.integer  'doc_reg_N',     limit: 4, index: { name: 'doc_reg_N', using: :btree }
    t.string   'Algorithm',     limit: 80
    t.datetime 't',             null: false
    t.string   'model',         limit: 64
    t.datetime 'import_t'
    t.string   'mod',           limit: 255
    t.integer  'eq_type',       limit: 4, index: { name: 'FK_pds_valves_eq', using: :btree }
    t.decimal  'level',         precision: 10, scale: 5
    t.string   'room',          limit: 32
    t.string   'panels',        limit: 64
    t.string   'connection',    limit: 16
    t.integer  'power_section', limit: 4, index: { name: 'power_section', using: :btree }
  end
  add_index 'pds_valves', %w(ed_power ctrl_power anc_power), name: 'ed_power_2', using: :btree
  add_index 'pds_valves', ['valveID'], name: 'valveID', unique: true, using: :btree

  create_table 'pds_valves_59', id: false, force: :cascade do |t|
    t.datetime 't',            null: false
    t.string   'mod',          limit: 255
    t.datetime 'import_t'
    t.integer  'valveID',      limit: 4, default: 0, null: false
    t.integer  'SystemID',     limit: 4
    t.string   'sys',          limit: 8, default: ''
    t.string   'tag_RU',       limit: 255
    t.string   'tag_EN',       limit: 255
    t.string   'Type',         limit: 10
    t.string   'station_sys',  limit: 128
    t.string   'Department',   limit: 10
    t.string   'Desc_RU',      limit: 255, default: '', null: false
    t.string   'Desc_EN',      limit: 255
    t.string   'PowerTemp',    limit: 50
    t.integer  'ed_powerID',   limit: 4
    t.string   'ed_power',     limit: 32
    t.integer  'ctrl_powerID', limit: 4
    t.string   'ctrl_power',   limit: 32
    t.integer  'anc_powerID',  limit: 4
    t.string   'anc_power',    limit: 32
    t.float    'nom_state',    limit: 53
    t.float    'open_rate',    limit: 53
    t.float    'close_rate',   limit: 53
    t.string   'Algorithm',    limit: 80
    t.string   'model',        limit: 64
    t.string   'connection',   limit: 16
  end

  create_table 'pds_valves_60', id: false, force: :cascade do |t|
    t.datetime 't',            null: false
    t.string   'mod',          limit: 255
    t.datetime 'import_t'
    t.integer  'valveID',      limit: 4, default: 0, null: false
    t.integer  'SystemID',     limit: 4
    t.string   'sys',          limit: 8, default: ''
    t.string   'tag_RU',       limit: 255
    t.string   'tag_EN',       limit: 255
    t.string   'Type',         limit: 10
    t.string   'station_sys',  limit: 128
    t.string   'Department',   limit: 10
    t.string   'Desc_RU',      limit: 255, default: '', null: false
    t.string   'Desc_EN',      limit: 255
    t.string   'PowerTemp',    limit: 50
    t.integer  'ed_powerID',   limit: 4
    t.string   'ed_power',     limit: 32
    t.integer  'ctrl_powerID', limit: 4
    t.string   'ctrl_power',   limit: 32
    t.integer  'anc_powerID',  limit: 4
    t.string   'anc_power',    limit: 32
    t.float    'nom_state',    limit: 53
    t.float    'open_rate',    limit: 53
    t.float    'close_rate',   limit: 53
    t.string   'Algorithm',    limit: 80
    t.string   'model',        limit: 64
    t.string   'connection',   limit: 16
    t.string   'eq_type',      limit: 3
  end

  create_table 'pds_valves_62', id: false, force: :cascade do |t|
    t.datetime 't',            null: false
    t.string   'mod',          limit: 255
    t.datetime 'import_t'
    t.integer  'valveID',      limit: 4, default: 0, null: false
    t.integer  'SystemID',     limit: 4
    t.string   'sys',          limit: 8, default: ''
    t.string   'tag_RU',       limit: 255
    t.string   'tag_EN',       limit: 255
    t.string   'Type',         limit: 10
    t.string   'station_sys',  limit: 128
    t.string   'Department',   limit: 10
    t.string   'Desc_RU',      limit: 255, default: '', null: false
    t.string   'Desc_EN',      limit: 255
    t.string   'PowerTemp',    limit: 50
    t.integer  'ed_powerID',   limit: 4
    t.string   'ed_power',     limit: 32
    t.integer  'ctrl_powerID', limit: 4
    t.string   'ctrl_power',   limit: 32
    t.integer  'anc_powerID',  limit: 4
    t.string   'anc_power',    limit: 32
    t.float    'nom_state',    limit: 53
    t.float    'open_rate',    limit: 53
    t.float    'close_rate',   limit: 53
    t.string   'Algorithm',    limit: 80
    t.string   'model',        limit: 64
    t.string   'connection',   limit: 16
    t.string   'eq_type',      limit: 3
  end

  create_table 'pds_valves_73', id: false, force: :cascade do |t|
    t.datetime 't',            null: false
    t.string   'mod',          limit: 255
    t.datetime 'import_t'
    t.integer  'valveID',      limit: 4, default: 0, null: false
    t.integer  'SystemID',     limit: 4
    t.string   'sys',          limit: 8, default: ''
    t.string   'tag_RU',       limit: 255
    t.string   'tag_EN',       limit: 255
    t.string   'Type',         limit: 10
    t.string   'station_sys',  limit: 128
    t.string   'Department',   limit: 10
    t.string   'Desc_RU',      limit: 255, default: '', null: false
    t.string   'Desc_EN',      limit: 255
    t.string   'PowerTemp',    limit: 50
    t.integer  'ed_powerID',   limit: 4
    t.string   'ed_power',     limit: 32
    t.integer  'ctrl_powerID', limit: 4
    t.string   'ctrl_power',   limit: 32
    t.integer  'anc_powerID',  limit: 4
    t.string   'anc_power',    limit: 32
    t.float    'nom_state',    limit: 53
    t.float    'open_rate',    limit: 53
    t.float    'close_rate',   limit: 53
    t.string   'Algorithm',    limit: 80
    t.string   'model',        limit: 64
    t.string   'connection',   limit: 16
    t.string   'eq_type',      limit: 3
  end

  create_table 'pds_volume', primary_key: 'volumeID', force: :cascade do |t|
    t.string  'kks',       limit: 15, null: false
    t.string  'ShortDesc', limit: 80
    t.text    'Desc_EN',   limit: 65_535
    t.float   'volume',    limit: 24
    t.float   'height',    limit: 24
    t.float   'level',     limit: 24
    t.string  'room',      limit: 15
    t.integer 'Project',   limit: 4, null: false, index: { name: 'FK_pds_volume', using: :btree }
    t.integer 'sys',       limit: 4, index: { name: 'FK_pds_volume_sys', using: :btree }
    t.integer 'eq_type',   limit: 4, index: { name: 'FK_pds_volume_eq_type', using: :btree }
    t.integer 'sd_N',      limit: 4, index: { name: 'sd_N', using: :btree }
  end

  create_table 'project_list', id: false, force: :cascade do |t|
    t.integer 'ProjectID', limit: 4, default: 0, null: false
    t.string  'Project',   limit: 101
  end

  create_table 'roles', primary_key: 'roleID', force: :cascade do |t|
    t.string 'role', limit: 5, null: false
    t.string 'Desc', limit: 50
  end
  add_index 'roles', ['roleID'], name: 'roleID', unique: true, using: :btree

  create_table 'roles_eng_prj', id: false, force: :cascade do |t|
    t.integer 'roleID',     limit: 1, null: false, index: { name: 'roleID', using: :btree }
    t.integer 'engineer_N', limit: 4, null: false, index: { name: 'engineer_N', using: :btree }
    t.integer 'ProjectID',  limit: 4, null: false, index: { name: 'projectID', using: :btree }
  end

  create_table 'sector', primary_key: 'sID', force: :cascade do |t|
    t.string  'sName',      limit: 255, null: false
    t.integer 'Manager_ID', limit: 4
  end

  create_table 'sign_rpt', primary_key: 'sID', force: :cascade do |t|
    t.integer 'engID',   limit: 4, null: false, index: { name: 'FK_sign_rpt', using: :btree }
    t.string  'engName', limit: 255, default: ''
    t.integer 'BlobObj', limit: 4, index: { name: 'FK_sign_rpt_BlobObj', using: :btree }
  end

  create_table 'table_role_rights', id: false, force: :cascade do |t|
    t.integer 'tableID', limit: 1, null: false, index: { name: 'tableID', using: :btree }
    t.integer 'roleID',  limit: 1, null: false, index: { name: 'roleID', using: :btree }
    t.integer 'value',   limit: 1, null: false
  end

  create_table 'tablelist', primary_key: 'tableID', force: :cascade do |t|
    t.string  'table',   limit: 50, index: { name: 'table', unique: true, using: :btree }
    t.string  'title',   limit: 50
    t.string  'Desc',    limit: 255
    t.integer 'BlobObj', limit: 4
    t.integer 'number',  limit: 4, null: false
  end
  add_index 'tablelist', ['tableID'], name: 'TableID', unique: true, using: :btree

  create_table 'tblbinaries', primary_key: 'ObjectID', force: :cascade do |t|
    t.string   'Title',  limit: 255
    t.string   'Type',   limit: 25
    t.integer  'Length', limit: 4
    t.binary   'binObj', limit: 16_777_215
    t.datetime 't',      null: false
  end
  add_index 'tblbinaries', ['ObjectID'], name: 'ObjectID', unique: true, using: :btree

  create_table 'test', force: :cascade do |t|
    t.integer 'llim',   limit: 4
    t.integer 'ulim',   limit: 4
    t.integer 'new_id', limit: 4
    t.string  'table',  limit: 255
  end

  create_table 'week_report', primary_key: 'ReportID', force: :cascade do |t|
    t.integer  'Project',    limit: 4, null: false, index: { name: 'Project', using: :btree }
    t.integer  'Engineer',   limit: 4, index: { name: 'Engineer', using: :btree }
    t.datetime 'ReportDate'
    t.integer  'sys',        limit: 4, index: { name: 'sys', using: :btree }
    t.text     'RptText',    limit: 65_535
    t.text     'Problems',   limit: 65_535
    t.time     't'
  end
  add_index 'week_report', ['ReportID'], name: 'ReportID', unique: true, using: :btree

  add_foreign_key 'audit', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'PRJ_KEY', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'contract', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'contract_ibfk_1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'dwg_panels', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'FK_dwg_panels1', on_update: :cascade
  add_foreign_key 'dwg_type_rotations', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'FK_dwg_type_rotations1', on_update: :cascade
  add_foreign_key 'hw_devtype', 'tablelist', column: 'typetable', primary_key: 'tableID', name: 'hw_devtype_ibfk_1'
  add_foreign_key 'hw_ic', 'hw_peds', column: 'ped', primary_key: 'ped_N', name: 'hw_ic_ibfk_6', on_update: :cascade
  add_foreign_key 'hw_ic', 'pds_panel', column: 'panel_id', primary_key: 'pID', name: 'FK_hw_ic22', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'hw_ic', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'hw_ic_ibfk_8', on_update: :cascade
  add_foreign_key 'hw_ic', 'pds_project_unit', column: 'Unit', primary_key: 'ProjUnitID', name: 'hw_ic_ibfk_7', on_update: :cascade
  add_foreign_key 'hw_ic', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'hw_ic_ibfk_9'
  add_foreign_key 'hw_ic_temp', 'hw_peds', column: 'ped', primary_key: 'ped_N', name: 'hw_ict_ibfk_6', on_update: :cascade
  add_foreign_key 'hw_ic_temp', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'hw_ict_ibfk_8', on_update: :cascade
  add_foreign_key 'hw_iosignal', 'hw_iosignaldef', column: 'signID', primary_key: 'ID', name: 'hw_iosignal_ibfk_3'
  add_foreign_key 'hw_iosignal', 'hw_peds', column: 'pedID', primary_key: 'ped_N', name: 'hw_iosignal_ibfk_4', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'hw_iosignal', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'hw_iosignal_ibfk_1', on_update: :cascade
  add_foreign_key 'hw_iosignaldim', 'hw_iosignal', column: 'signID', primary_key: 'ID', name: 'FK_hw_iosignaldim2', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'hw_iosignaldim', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'FK_hw_iosignaldim1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'hw_peds', 'hw_devtype', column: 'type', primary_key: 'typeID', name: 'hw_peds_ibfk_3'
  add_foreign_key 'hw_peds', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'hw_peds_ibfk_1', on_update: :cascade
  add_foreign_key 'hw_wirelist', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'hw_wirelist_ibfk_6', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'hw_wirelist', 'hw_iosignal', column: 'io_signalID', primary_key: 'ID', name: 'hw_wirelist_ibfk_7', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'hw_wirelist', 'hw_peds', column: 'ped', primary_key: 'ped_N', name: 'hw_wirelist_ibfk_3', on_update: :cascade
  add_foreign_key 'hw_wirelist', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'hw_wirelist_ibfk_5', on_update: :cascade
  add_foreign_key 'hw_wirelist', 'pds_project_unit', column: 'Unit', primary_key: 'ProjUnitID', name: 'hw_wirelist_ibfk_4', on_update: :cascade
  add_foreign_key 'input_letters', 'lettrs_adressat', column: 'To', primary_key: 'adressatID', name: 'input_letters_ibfk_2'
  add_foreign_key 'input_letters', 'pds_engineers', column: 'From', primary_key: 'engineer_N', name: 'input_letters_ibfk_1', on_delete: :nullify
  add_foreign_key 'input_letters', 'tblbinaries', column: 'BlobObj', primary_key: 'ObjectID', name: 'input_letters_ibfk_3'
  add_foreign_key 'pds_air_valves', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_air_valves_ibfk_5', on_update: :cascade
  add_foreign_key 'pds_air_valves', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_air_valves_ibfk_6', on_update: :cascade
  add_foreign_key 'pds_air_valves', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_air_valves_ibfk_4'
  add_foreign_key 'pds_alarm', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_alarm_ibfk_4', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_alarm', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_alarm_ibfk_5', on_update: :cascade
  add_foreign_key 'pds_alarm', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_alarm_ibfk_6', on_update: :cascade
  add_foreign_key 'pds_algo_inputs', 'pds_algorithms', column: 'Algorithm', primary_key: 'AlgoID', name: 'pds_algo_inputs_ibfk_1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_algo_inputs', 'pds_project_unit', column: 'Unit', primary_key: 'ProjUnitID', name: 'pds_algo_inputs_ibfk_2'
  add_foreign_key 'pds_algo_outs', 'pds_algorithms', column: 'Algorithm', primary_key: 'AlgoID', name: 'pds_algo_outs_ibfk_1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_algo_outs', 'pds_project_unit', column: 'Unit', primary_key: 'ProjUnitID', name: 'pds_algo_outs_ibfk_2'
  add_foreign_key 'pds_algorithms', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_algorithms_ibfk_1'
  add_foreign_key 'pds_announciator', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_announciator_ibfk_20', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_announciator', 'pds_detectors', column: 'Detector', primary_key: 'DetID', name: 'pds_announciator_ibfk_23', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_announciator', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_announciator_ibfk_19', on_update: :cascade
  add_foreign_key 'pds_announciator', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_announciator_ibfk_21', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_announciator', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_announciator_ibfk_22', on_update: :cascade
  add_foreign_key 'pds_blocks', 'pds_documentation', column: 'doc', primary_key: 'DocID', name: 'pds_blocks_ibfk_2', on_update: :cascade
  add_foreign_key 'pds_blocks', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_blocks_ibfk_3', on_update: :cascade
  add_foreign_key 'pds_blocks', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_blocks_ibfk_1', on_update: :cascade
  add_foreign_key 'pds_blocks_systems', 'pds_blocks', column: 'block', primary_key: 'blockID', name: 'pds_blocks_systems_ibfk_3', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_blocks_systems', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_blocks_systems_ibfk_4', on_update: :cascade
  add_foreign_key 'pds_breakers', 'pds_man_equip', column: 'eq_type', primary_key: 'EquipN', name: 'FK_pds_breakers_eq_type1', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_breakers', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_breakers_ibfk_5', on_update: :cascade
  add_foreign_key 'pds_breakers', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'pds_breakers_sd_N', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_breakers', 'pds_section_assembler', column: 'anc_power', primary_key: 'section_N', name: 'pds_breakers_ibfk_7', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_breakers', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_breakers_ibfk_6', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_breakers', 'pds_section_assembler', column: 'ed_power', primary_key: 'section_N', name: 'FK_pds_breakers_ed_power1', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_breakers', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_breakers_ibfk_1'
  add_foreign_key 'pds_bru', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_bru_ibfk_5', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_bru', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_bru_ibfk_6', on_update: :cascade
  add_foreign_key 'pds_bru', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_bru_ibfk_7', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_bru', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_bru_ibfk_4'
  add_foreign_key 'pds_buttons', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_buttons_ibfk_4', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_buttons', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_buttons_ibfk_5', on_update: :cascade
  add_foreign_key 'pds_buttons', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_buttons_ibfk_3'
  add_foreign_key 'pds_buttons_lights', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_buttons_lights_ibfk_6', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_buttons_lights', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_buttons_lights_ibfk_7', on_update: :cascade
  add_foreign_key 'pds_buttons_lights', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_buttons_lights_ibfk_8', on_delete: :nullify
  add_foreign_key 'pds_buttons_lights', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_buttons_lights_ibfk_5'
  add_foreign_key 'pds_customers', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_customers_ibfk_1', on_update: :cascade
  add_foreign_key 'pds_detectors', 'pds_documentation', column: 'doc_reg_N', primary_key: 'DocID', name: 'pds_detectors_ibfk_16', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_detectors', 'pds_man_equip', column: 'eq_type', primary_key: 'EquipN', name: 'FK_pds_detectors_eq_type1', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_detectors', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_detectors_ibfk_14', on_update: :cascade
  add_foreign_key 'pds_detectors', 'pds_project_unit', column: 'Unit', primary_key: 'ProjUnitID', name: 'pds_detectors_ibfk_19', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_detectors', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'pds_detectors_ibfk_17', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_detectors', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_detectors_ibfk_18', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_detectors', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_detectors_ibfk_10'
  add_foreign_key 'pds_doc_on_sys', 'pds_documentation', column: 'Doc', primary_key: 'DocID', name: 'pds_doc_on_sys_ibfk_5', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_doc_on_sys', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_doc_on_sys_ibfk_4'
  add_foreign_key 'pds_documentation', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_documentation_ibfk_5', on_update: :cascade
  add_foreign_key 'pds_documents', 'pds_engineers', column: 'Author', primary_key: 'engineer_N', name: 'pds_documents_ibfk_1', on_update: :cascade
  add_foreign_key 'pds_documents', 'pds_engineers', column: 'CheckOutEn', primary_key: 'engineer_N', name: 'pds_documents_ibfk_4', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_documents', 'pds_engineers', column: 'CheckOutRu', primary_key: 'engineer_N', name: 'pds_documents_ibfk_5', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_documents', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_documents_ibfk_2', on_update: :cascade
  add_foreign_key 'pds_dr', 'pds_engineers', column: 'closedBy', primary_key: 'engineer_N', name: 'FK_pds_dr_5', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_dr', 'pds_engineers', column: 'drAuthor', primary_key: 'engineer_N', name: 'FK_pds_dr_3', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_dr', 'pds_engineers', column: 'replyAuthor', primary_key: 'engineer_N', name: 'FK_pds_dr_4', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_dr', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_dr_ibfk_2', on_update: :cascade
  add_foreign_key 'pds_dr', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_dr_ibfk_1'
  add_foreign_key 'pds_dr_stats', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'FK_pds_dr_stats1'
  add_foreign_key 'pds_dr_stats', 'pds_syslist', column: 'sys_id', primary_key: 'SystemID', name: 'FK_pds_dr_stats_sys1'
  add_foreign_key 'pds_ejector', 'pds_man_equip', column: 'eq_type', primary_key: 'EquipN', name: 'FK_pds_ejector_eq_type1', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_ejector', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'FK_pds_ejector1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_ejector', 'pds_project_unit', column: 'Unit', primary_key: 'ProjUnitID', name: 'FK_pds_ejector_unit1', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_ejector', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'FK_pds_ejector_sd_N', on_update: :cascade
  add_foreign_key 'pds_ejector', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'FK_pds_ejector_sys1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_eng_on_sys', 'pds_engineers', column: 'TestOperator_N', primary_key: 'engineer_N', name: 'pds_eng_on_sys_ibfk_7', on_update: :cascade
  add_foreign_key 'pds_eng_on_sys', 'pds_engineers', column: 'engineer_N', primary_key: 'engineer_N', name: 'pds_eng_on_sys_ibfk_6', on_update: :cascade
  add_foreign_key 'pds_eng_on_sys', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_eng_on_sys_ibfk_8', on_update: :cascade
  add_foreign_key 'pds_eng_on_sys', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_eng_on_sys_ibfk_4'
  add_foreign_key 'pds_engineers', 'staff', column: 'coreID', primary_key: 'ID', name: 'pds_engineers_ibfk_1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_equipments', 'pds_equips', column: 'type_equip', primary_key: 'TEquipID', name: 'FK_pds_equipments_type', on_update: :cascade
  add_foreign_key 'pds_equipments', 'pds_man_equip', column: 'eq_type', primary_key: 'EquipN', name: 'FK_pds_equipments_eq_type1', on_update: :cascade
  add_foreign_key 'pds_equipments', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'FK_pds_equipments1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_equipments', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'FK_pds_equipments_sd_N', on_update: :cascade
  add_foreign_key 'pds_equipments', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'FK_pds_equipments_sys1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_filter', 'pds_man_equip', column: 'eq_type', primary_key: 'EquipN', name: 'FK_pds_filter_eq_type', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_filter', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'FK_pds_filter', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_filter', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'FK_pds_filter_sd_N', on_update: :cascade
  add_foreign_key 'pds_filter', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'FK_pds_filter_sys', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_hex', 'pds_man_equip', column: 'eq_type', primary_key: 'EquipN', name: 'FK_pds_hex_eq_type', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_hex', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'FK_pds_hex', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_hex', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'FK_pds_hex_sd_N', on_update: :cascade
  add_foreign_key 'pds_hex', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'FK_pds_hex_sys', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_iomap', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_iomap_ibfk_2', on_update: :cascade
  add_foreign_key 'pds_iomap', 'pds_sids', column: 'sid', primary_key: 'sid_N', name: 'pds_iomap_ibfk_1', on_update: :cascade
  add_foreign_key 'pds_lamps', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_lamps_ibfk_23', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_lamps', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_lamps_ibfk_24', on_update: :cascade
  add_foreign_key 'pds_lamps', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_lamps_ibfk_22', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_lamps', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_lamps_ibfk_21'
  add_foreign_key 'pds_malfunction', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_malfunction_ibfk_2', on_update: :cascade
  add_foreign_key 'pds_malfunction', 'pds_project_unit', column: 'regidity_unitid', primary_key: 'ProjUnitID', name: 'pds_malfunction_ibfk_3'
  add_foreign_key 'pds_malfunction', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'FK_pds_malfunction', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_malfunction', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_malfunction_ibfk_1'
  add_foreign_key 'pds_malfunction_dim', 'pds_malfunction', column: 'Malfunction', primary_key: 'MalfID', name: 'pds_malfunction_dim_ibfk_7', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_malfunction_dim', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_malfunction_dim_ibfk_4', on_update: :cascade
  add_foreign_key 'pds_malfunction_dim', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'pds_malfunction_dim_ibfk_6', on_update: :cascade
  add_foreign_key 'pds_mathmodel', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'FK_pds_mathmodel_prj', on_delete: :cascade
  add_foreign_key 'pds_mathmodel', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'FK_pds_mathmodel_sys', on_delete: :cascade
  add_foreign_key 'pds_meters', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_meters_ibfk_20', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_meters', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_meters_ibfk_22', on_update: :cascade
  add_foreign_key 'pds_meters', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_meters_ibfk_21', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_meters', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_meters_ibfk_19'
  add_foreign_key 'pds_meters_channels', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_meters_channels_ibfk_6', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_meters_channels', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_meters_channels_ibfk_7', on_update: :cascade
  add_foreign_key 'pds_meters_channels', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_meters_channels_ibfk_8', on_update: :cascade
  add_foreign_key 'pds_meters_channels', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_meters_channels_ibfk_5'
  add_foreign_key 'pds_meters_digital', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_meters_digital_ibfk_6', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_meters_digital', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_meters_digital_ibfk_7', on_update: :cascade
  add_foreign_key 'pds_meters_digital', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_meters_digital_ibfk_8', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_meters_digital', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_meters_digital_ibfk_5'
  add_foreign_key 'pds_misc', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_misc_ibfk_6', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_misc', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_misc_ibfk_7', on_update: :cascade
  add_foreign_key 'pds_misc', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_misc_ibfk_8', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_misc', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_misc_ibfk_5'
  add_foreign_key 'pds_mnemo', 'pds_detectors', column: 'Detector', primary_key: 'DetID', name: 'pds_mnemo_ibfk_5', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_mnemo', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_mnemo_ibfk_4', on_update: :cascade
  add_foreign_key 'pds_mnemo', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_mnemo_ibfk_3'
  add_foreign_key 'pds_motors', 'pds_documentation', column: 'doc_reg_N', primary_key: 'DocID', name: 'pds_motors_ibfk_27', on_update: :cascade
  add_foreign_key 'pds_motors', 'pds_man_equip', column: 'eq_type', primary_key: 'EquipN', name: 'FK_pds_motors_eq_type', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_motors', 'pds_motor_type', column: 'MotorType', primary_key: 'MotorTypeID', name: 'pds_motors_ibfk_32', on_update: :cascade
  add_foreign_key 'pds_motors', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_motors_ibfk_33', on_update: :cascade
  add_foreign_key 'pds_motors', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'pds_motors_ibfk_28', on_update: :cascade
  add_foreign_key 'pds_motors', 'pds_section_assembler', column: 'anc_power', primary_key: 'section_N', name: 'pds_motors_ibfk_31', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_motors', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_motors_ibfk_30', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_motors', 'pds_section_assembler', column: 'ed_power', primary_key: 'section_N', name: 'pds_motors_ibfk_29', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_motors', 'pds_section_assembler', column: 'power_section', primary_key: 'section_N', name: 'pds_motors_ibfk_34', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_motors', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_motors_ibfk_26'
  add_foreign_key 'pds_panel', 'hw_ic', column: 'lamptest', primary_key: 'icID', name: 'pds_panel_ibfk_3', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_panel', 'hw_ic', column: 'memsjem', primary_key: 'icID', name: 'pds_panel_ibfk_9', on_delete: :nullify
  add_foreign_key 'pds_panel', 'hw_ic', column: 'migsjem', primary_key: 'icID', name: 'pds_panel_ibfk_1', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_panel', 'hw_ic', column: 'pressconfirm', primary_key: 'icID', name: 'pds_panel_ibfk_6', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_panel', 'hw_ic', column: 'soundsjem', primary_key: 'icID', name: 'pds_panel_ibfk_10', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_panel', 'hw_ic', column: 'soundtest', primary_key: 'icID', name: 'pds_panel_ibfk_11', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_panel', 'hw_ic', column: 'soundtest_alarm', primary_key: 'icID', name: 'pds_panel_ibfk_7', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_panel', 'hw_ic', column: 'soundtest_warn', primary_key: 'icID', name: 'pds_panel_ibfk_4', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_panel', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_panel_ibfk_8', on_update: :cascade
  add_foreign_key 'pds_ppca', 'pds_detectors', column: 'Detector', primary_key: 'DetID', name: 'pds_ppca_ibfk_5'
  add_foreign_key 'pds_ppca', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_ppca_ibfk_4', on_update: :cascade
  add_foreign_key 'pds_ppca', 'pds_project_unit', column: 'UnitID', primary_key: 'ProjUnitID', name: 'pds_ppca_ibfk_6'
  add_foreign_key 'pds_ppca', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_ppca_ibfk_3'
  add_foreign_key 'pds_ppcd', 'pds_detectors', column: 'Detector', primary_key: 'DetID', name: 'pds_ppcd_ibfk_3'
  add_foreign_key 'pds_ppcd', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_ppcd_ibfk_1'
  add_foreign_key 'pds_ppcd', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_ppcd_ibfk_2'
  add_foreign_key 'pds_project', 'company', column: 'companyID', primary_key: 'cID', name: 'fk_company', on_update: :cascade
  add_foreign_key 'pds_project', 'pds_engineers', column: 'HWManager', primary_key: 'engineer_N', name: 'pds_project_ibfk_7', on_update: :cascade
  add_foreign_key 'pds_project', 'pds_engineers', column: 'ProjectManager', primary_key: 'engineer_N', name: 'pds_project_ibfk_8', on_update: :cascade
  add_foreign_key 'pds_project', 'pds_engineers', column: 'SWManager', primary_key: 'engineer_N', name: 'pds_project_ibfk_9', on_update: :cascade
  add_foreign_key 'pds_project', 'tblbinaries', column: 'BlobObj', primary_key: 'ObjectID', name: 'pds_project_ibfk_6', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_project_properties', 'pds_project', column: 'ProjectID', primary_key: 'ProjectID', name: 'pds_project_properties_ibfk_1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_project_sys', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_project_sys_ibfk_3', on_update: :cascade
  add_foreign_key 'pds_project_sys', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_project_sys_ibfk_2'
  add_foreign_key 'pds_project_unit', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_project_unit_ibfk_3', on_update: :cascade
  add_foreign_key 'pds_project_unit', 'pds_unit', column: 'Unit', primary_key: 'UnitID', name: 'pds_project_unit_ibfk_4', on_update: :cascade
  add_foreign_key 'pds_queries', 'pds_engineers', column: 'engineer_N', primary_key: 'engineer_N', name: 'pds_queries_ibfk_8', on_update: :cascade
  add_foreign_key 'pds_queries', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_queries_ibfk_10', on_update: :cascade
  add_foreign_key 'pds_queries', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_queries_ibfk_7'
  add_foreign_key 'pds_recorders', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_recorders_ibfk_5', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_recorders', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_recorders_ibfk_6', on_update: :cascade
  add_foreign_key 'pds_recorders', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_recorders_ibfk_7', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_recorders', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_recorders_ibfk_4'
  add_foreign_key 'pds_regulators', 'pds_detectors', column: 'det_id', primary_key: 'DetID', name: 'FK_pds_regulators_det_id', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_regulators', 'pds_documentation', column: 'doc_reg_N', primary_key: 'DocID', name: 'pds_regulators_ibfk_25', on_update: :cascade
  add_foreign_key 'pds_regulators', 'pds_man_equip', column: 'eq_type', primary_key: 'EquipN', name: 'FK_pds_regulators_eq_type', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_regulators', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_regulators_ibfk_30', on_update: :cascade
  add_foreign_key 'pds_regulators', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'pds_regulators_ibfk_26', on_update: :cascade
  add_foreign_key 'pds_regulators', 'pds_section_assembler', column: 'anc_power', primary_key: 'section_N', name: 'pds_regulators_ibfk_29', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_regulators', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_regulators_ibfk_28', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_regulators', 'pds_section_assembler', column: 'ed_power', primary_key: 'section_N', name: 'pds_regulators_ibfk_27', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_regulators', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_regulators_ibfk_24'
  add_foreign_key 'pds_regulators', 'pds_valves', column: 'vlv_1', primary_key: 'valveID', name: 'FK_pds_regulators', on_update: :cascade
  add_foreign_key 'pds_regulators', 'pds_valves', column: 'vlv_2', primary_key: 'valveID', name: 'FK_pds_regulators_2', on_update: :cascade
  add_foreign_key 'pds_rf', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_rf_ibfk_14', on_update: :cascade
  add_foreign_key 'pds_rf', 'pds_project_unit', column: 'Unit', primary_key: 'ProjUnitID', name: 'pds_rf_ibfk_12', on_update: :cascade
  add_foreign_key 'pds_rf', 'pds_project_unit', column: 'unit_FB', primary_key: 'ProjUnitID', name: 'pds_rf_ibfk_13', on_update: :cascade
  add_foreign_key 'pds_rf', 'pds_rf', column: 'frfID', primary_key: 'rfID', name: 'FK_pds_rf', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_rf', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'pds_rf_ibfk_15', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_rf', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_rf_ibfk_10'
  add_foreign_key 'pds_sd', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_sd_ibfk_6', on_update: :cascade
  add_foreign_key 'pds_sd', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_sd_ibfk_5'
  add_foreign_key 'pds_sd', 'tblbinaries', column: 'BlobObj', primary_key: 'ObjectID', name: 'pds_sd_ibfk_7', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_section_assembler', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_section_assembler_ibfk_1', on_update: :cascade
  add_foreign_key 'pds_set', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_set_ibfk_5', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_set', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_set_ibfk_6', on_update: :cascade
  add_foreign_key 'pds_set', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_set_ibfk_4'
  add_foreign_key 'pds_sids', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_sids_ibfk_9', on_update: :cascade
  add_foreign_key 'pds_simplifications', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_simplifications_ibfk_8', on_update: :cascade
  add_foreign_key 'pds_simplifications', 'pds_queries', column: 'queryID', primary_key: 'queryID', name: 'pds_simplifications_ibfk_7', on_update: :cascade
  add_foreign_key 'pds_simplifications', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_simplifications_ibfk_6'
  add_foreign_key 'pds_switch_fix', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_switch_fix_ibfk_18', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_switch_fix', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_switch_fix_ibfk_17', on_update: :cascade
  add_foreign_key 'pds_switch_fix', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_switch_fix_ibfk_16'
  add_foreign_key 'pds_switch_nofix', 'hw_ic', column: 'IC', primary_key: 'icID', name: 'pds_switch_nofix_ibfk_5', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_switch_nofix', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_switch_nofix_ibfk_4', on_update: :cascade
  add_foreign_key 'pds_switch_nofix', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_switch_nofix_ibfk_3'
  add_foreign_key 'pds_sys_description', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_sys_description_ibfk_3', on_update: :cascade
  add_foreign_key 'pds_sys_description', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_sys_description_ibfk_2'
  add_foreign_key 'pds_valves', 'pds_documentation', column: 'doc_reg_N', primary_key: 'DocID', name: 'pds_valves_ibfk_25', on_update: :cascade
  add_foreign_key 'pds_valves', 'pds_man_equip', column: 'eq_type', primary_key: 'EquipN', name: 'FK_pds_valves_eq', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_valves', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'pds_valves_ibfk_29', on_update: :cascade
  add_foreign_key 'pds_valves', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'pds_valves_ibfk_24', on_update: :cascade
  add_foreign_key 'pds_valves', 'pds_section_assembler', column: 'anc_power', primary_key: 'section_N', name: 'pds_valves_ibfk_27', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_valves', 'pds_section_assembler', column: 'ctrl_power', primary_key: 'section_N', name: 'pds_valves_ibfk_26', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_valves', 'pds_section_assembler', column: 'ed_power', primary_key: 'section_N', name: 'pds_valves_ibfk_28', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_valves', 'pds_section_assembler', column: 'power_section', primary_key: 'section_N', name: 'pds_valves_ibfk_30', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_valves', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'pds_valves_ibfk_23'
  add_foreign_key 'pds_volume', 'pds_man_equip', column: 'eq_type', primary_key: 'EquipN', name: 'FK_pds_volume_eq_type', on_update: :cascade, on_delete: :nullify
  add_foreign_key 'pds_volume', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'FK_pds_volume', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'pds_volume', 'pds_sd', column: 'sd_N', primary_key: 'sd_N', name: 'FK_pds_volume_sd_N', on_update: :cascade
  add_foreign_key 'pds_volume', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'FK_pds_volume_sys', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'roles_eng_prj', 'pds_engineers', column: 'engineer_N', primary_key: 'engineer_N', name: 'roles_eng_prj_ibfk_2', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'roles_eng_prj', 'pds_project', column: 'ProjectID', primary_key: 'ProjectID', name: 'roles_eng_prj_ibfk_3', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'roles_eng_prj', 'roles', column: 'roleID', primary_key: 'roleID', name: 'roles_eng_prj_ibfk_1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'sign_rpt', 'pds_engineers', column: 'engID', primary_key: 'engineer_N', name: 'FK_sign_rpt', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'sign_rpt', 'tblbinaries', column: 'BlobObj', primary_key: 'ObjectID', name: 'FK_sign_rpt_BlobObj', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'table_role_rights', 'roles', column: 'roleID', primary_key: 'roleID', name: 'table_role_rights_ibfk_3', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'table_role_rights', 'tablelist', column: 'tableID', primary_key: 'tableID', name: 'table_role_rights_ibfk_2', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'week_report', 'pds_engineers', column: 'Engineer', primary_key: 'engineer_N', name: 'week_report_ibfk_1', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'week_report', 'pds_project', column: 'Project', primary_key: 'ProjectID', name: 'week_report_ibfk_5', on_update: :cascade
  add_foreign_key 'week_report', 'pds_syslist', column: 'sys', primary_key: 'SystemID', name: 'week_report_ibfk_4'
end
