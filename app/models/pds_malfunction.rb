# frozen_string_literal: true

class PdsMalfunction < ApplicationRecord
  # self.inheritance_column = nil
  self.inheritance_column = :_type_disabled
  self.table_name = 'pds_malfunction'

  include DbmGeneratorHelper
  attr_accessor :skip_callbacks

  alias_attribute :id, primary_key
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project_unit, foreign_key: 'regidity_unitid'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N', inverse_of: :pds_malfunctions

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

  CHARACTER_ARRAY = ('A'..'Z').to_a + ('AA'..'ZZ').to_a

  after_commit :check_dims, on: %i[create update]

  def check_dims
    return if skip_callbacks

    pds_malfunction = self
    pds_malfunction_dims = PdsMalfunctionDim.where(Malfunction: pds_malfunction.id).order(:Character).to_a
    icnt = pds_malfunction.Dimension - pds_malfunction_dims.size
    icnt = 0 if pds_malfunction.Dimension < 1
    if icnt.positive?
      while icnt.positive?
        pds_malfunction_dim = PdsMalfunctionDim.new
        pds_malfunction_dim.Project = pds_malfunction.Project
        pds_malfunction_dim.Malfunction = pds_malfunction.id
        pds_malfunction_dim.sd_N = pds_malfunction.sd_N
        pds_malfunction_dim.Character = CHARACTER_ARRAY[(pds_malfunction.Dimension - icnt)]
        pds_malfunction_dim.save
        icnt -= 1
      end
    elsif icnt.negative?
      while icnt.negative?
        pds_malfunction_dim = PdsMalfunctionDim.where(Malfunction: pds_malfunction.id).order(:Character).last
        pds_malfunction_dim.destroy
        icnt += 1
      end
    end
    return unless pds_malfunction.Dimension == 1

    pds_malfunction_dim = PdsMalfunctionDim.where(Malfunction: pds_malfunction.id).last
    pds_malfunction_dim.Character = ''
    pds_malfunction_dim.save
  end

  before_destroy do |pds_malfunction|
    pds_malfunction_dim = PdsMalfunctionDim.where(Malfunction: pds_malfunction.id).order(:Character).to_a
    pds_malfunction_dim.each(&:destroy)
  end

  # TODO: add with language
  # (*) – В случае, если длина описания больше 66 символов, то общая длина 2-ой строки обрезается по 72-ой символ и при этом ниже генерятся две
  # служебных строки в виде:
  # @DESC1(1 часть описания (не длиннее 66 символов, разбивается по словам))
  # @DESC2(продолжение описания)
  #  def description
  #    Desc
  #  end
  #

  # this part is for fbm generator
  def type_b?(t)
    %w[GBN GBR IBN IBR].include?(t)
  end

  def type_r?(t)
    %w[GVN GVR IVN IVR].include?(t)
  end

  def number_by_letter(letter)
    CHARACTER_ARRAY.index(letter)
  end
end
