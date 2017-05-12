class HwPed < ApplicationRecord
  self.inheritance_column = nil
  self.table_name = 'hw_peds'
  alias_attribute :id, primary_key

  belongs_to :hw_devtype, foreign_key: :type
  has_many :hw_ic, dependent: :restrict_with_error, foreign_key: 'pedID'
  has_many :hw_wirelist, dependent: :restrict_with_error, foreign_key: 'pedID'

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

  SIGNAL_ARRAY = ['AI', 'AO', 'AO*', 'DI', 'LO', 'LO*', 'LO+', 'LO220', 'RO', 'DO'].freeze

  after_save do |hw_ped|
    if hw_ped.GenExtSig == 'да'
      SIGNAL_ARRAY.each do |sig_name|
        sig_id = HwIosignaldef.where(ioname: sig_name).first.id
        hw_iosignals = HwIosignal.where(pedID: hw_ped.id, signID: sig_id).to_a
        icnt = hw_ped[sig_name] - hw_iosignals.size
        icnt = 0 if hw_ped[sig_name] < 1
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
            hw_iosignal = HwIosignal.where(pedID: hw_ped.id, signID: sig_id).last
            hw_iosignal.skip_check_ped
            hw_iosignal.destroy
            icnt += 1
          end
        end
      end
    end
  end
end
