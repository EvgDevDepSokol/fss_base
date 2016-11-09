class PdsMalfunction < ActiveRecord::Base
  # self.inheritance_column = nil
  self.inheritance_column = :_type_disabled
  self.table_name = 'pds_malfunction'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project_unit, foreign_key: 'regidity_unitid'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N'

  alias_attribute :system_id, :sys
  alias_attribute :pds_project_unit_id, :regidity_unitid
  alias_attribute :sd_sys_numb_id, :sd_N

  has_many :items, class_name: 'PdsMalfunctionDim', foreign_key: :Malfunction

  validates :Dimension, numericality: { only_integer: true, greater_than: 0 }
  validates :Numb, numericality: { only_integer: true, greater_than: 0 }

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_project_unit: { only: [], include: { unit: { only: :Unit_RU } } },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end

  after_save do |pds_malfunction|
    pds_malfunction_dim=PdsMalfunctionDim.where(Malfunction: pds_malfunction.id).order(:Character).to_a
    byebug
    icnt=pds_malfunction.Dimension-pds_malfunction_dim.size
    if (pds_malfunction.Dimension<1)
      icnt=0
    end
    if (icnt>0)
      while icnt>0
        m_d_new=PdsMalfunctionDim.new
        m_d_new.Project=pds_malfunction.Project
        m_d_new.Malfunction=pds_malfunction.id
        m_d_new.sd_N=pds_malfunction.sd_N
        # m_d_new.Character=pds_malfunction_dim.last.Character
        m_d_new.save
        icnt -= 1
      end
    elsif(icnt<0)
      while icnt<0
        byebug
        m_d_new=PdsMalfunctionDim.where(Malfunction: pds_malfunction.id).order(:Character).last
        m_d_new.destroy
        icnt += 1
      end
    end
  end

  before_destroy do |pds_malfunction|
    pds_malfunction_dim=PdsMalfunctionDim.where(Malfunction: pds_malfunction.id).order(:Character).to_a
    pds_malfunction_dim.each do |m_d_new|
      m_d_new.destroy
    end
  end

  # TODO: add with language
  # (*) – В случае, если длина описания больше 66 символов, то общая длина 2-ой строки обрезается по 72-ой символ и при этом ниже генерятся две
  # служебных строки в виде:
  # @DESC1(1 часть описания (не длиннее 66 символов, разбивается по словам))
  # @DESC2(продолжение описания)
  #  def description
  #    Desc
  #  end
end
