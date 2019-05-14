# frozen_string_literal: true

class HwPed < ApplicationRecord
  self.inheritance_column = nil
  self.table_name = 'hw_peds'
  alias_attribute :id, primary_key

  belongs_to :hw_devtype, foreign_key: :type
  has_many :hw_ic, dependent: :restrict_with_error, foreign_key: 'ped'
  has_many :hw_wirelist, dependent: :restrict_with_error, foreign_key: 'pedID'

  validates :AI, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :AO, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates 'AO*', numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :DI, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :LO, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates 'LO*', numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates 'LO+', numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :LO220, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :RO, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :DO, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_destroy do |hw_ped|
    if hw_ped.GenExtSig == 'да'
      hw_iosignals = HwIosignal.where(pedID: hw_ped.id).to_a
      hw_iosignals.each(&:skip_check_ped)
      hw_iosignals.each(&:destroy)
    end
  end

  has_many :hw_iosignal, dependent: :restrict_with_error, foreign_key: 'pedID'

  alias_attribute :hw_devtype_id, :type

  def custom_hash
    serializable_hash(include: { hw_devtype: { only: [:RuName] } })
  end

  def gen_ext?
    self.GenExtSig == 'да'
  end

  SIGNAL_ARRAY = ['AI', 'AO', 'AO*', 'DI', 'LO', 'LO*', 'LO+', 'LO220', 'RO', 'DO'].freeze

  def signals
    SIGNAL_ARRAY
  end

  after_save do |hw_ped|
    if hw_ped.GenExtSig == 'да'
      SIGNAL_ARRAY.each do |sig_name|
        sig_id = HwIosignaldef.where(ioname: sig_name).first.id
        hw_iosignals = HwIosignal.where(pedID: hw_ped.id, signID: sig_id).order(:id).to_a
        icnt = hw_ped[sig_name] - hw_iosignals.size
        icnt = 0 if hw_ped[sig_name] < 0
        if icnt > 0
          while icnt > 0
            hw_iosignal = HwIosignal.new
            hw_iosignal.Project = hw_ped.Project
            hw_iosignal.pedID = hw_ped.id
            hw_iosignal.signID = sig_id
            hw_iosignal.skip_check_ped
            hw_iosignal.save
            icnt -= 1
          end
        elsif icnt < 0
          while icnt < 0
            hw_iosignal = HwIosignal.where(pedID: hw_ped.id, signID: sig_id).order(:id).last
            hw_iosignal.skip_check_ped
            hw_iosignal.destroy
            icnt += 1
          end
        end
      end
    end
  end

  after_save do |hw_ped|
    if hw_ped.type_before_last_save && (hw_ped.type != hw_ped.type_before_last_save)
      tbl_old = Object.const_get(Tablelist.find(HwDevtype.find(hw_ped.type_before_last_save).typetable).table.classify)
      tbl_new = Object.const_get(Tablelist.find(HwDevtype.find(hw_ped.type).typetable).table.classify)
      hw_ics = HwIc.where(Project: self.Project, ped: id).to_a
      hw_ics.each do |hw_ic|
        e_old = tbl_old.where(IC: hw_ic.icID).to_a
        e_old.each(&:destroy)

        e_new = tbl_new.new
        e_new.IC = hw_ic.icID
        e_new.Project = hw_ic.Project
        e_new.save
      end
    end
  end
end
