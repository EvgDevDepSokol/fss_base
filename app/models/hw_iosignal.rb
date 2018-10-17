class HwIosignal < ApplicationRecord
  self.table_name = 'hw_iosignal'
  alias_attribute :id, primary_key

  belongs_to :hw_ped, foreign_key: :pedID, class_name: 'HwPed'
  belongs_to :hw_iosignaldef, foreign_key: :signID, class_name: 'HwIosignaldef'
  alias_attribute :hw_ped_id, :pedID
  alias_attribute :hw_iosignaldef_id, :signID

  before_destroy :check_for_genextsig
  before_create :check_for_genextsig
  before_save :check_for_genextsig_signid

  def custom_hash
    serializable_hash(include: {
                        hw_ped: { only: [:ped] },
                        hw_iosignaldef: { only: [:ioname] }
                      })
  end

  def skip_check_ped
    @skip_check_ped = true
  end

  private

  def check_for_genextsig
    hw_ped = HwPed.where(id: hw_ped_id).first
    if hw_ped.gen_ext? && !@skip_check_ped
      errors.add(:base, :check_for_genextsig_err, ped: hw_ped.ped)
      throw(:abort)
    end
  end

  def check_for_genextsig_signid
    hw_ped = HwPed.where(id: hw_ped_id).first
    if hw_ped.gen_ext? && (signID != signID_before_last_save) && !@skip_check_ped
      errors.add(:base, :check_for_genextsig_signid_err, ped: hw_ped.ped)
      throw(:abort)
    end
  end
end
