class PdsDocumentation < ApplicationRecord
  self.table_name = 'pds_documentation'
  alias_attribute :id, primary_key

  has_many :pds_blocks, dependent: :restrict_with_error, foreign_key: 'doc'
  has_many :pds_doc_on_sys, dependent: :restrict_with_error, foreign_key: 'Doc'
  has_many :pds_detectors, dependent: :restrict_with_error, foreign_key: 'doc_reg_N'
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'doc_reg_N'
  has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'doc_reg_N'
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'doc_reg_N'

  def self.plucked
    true
  end

  def custom_hash
    serializable_hash(includes: [pds_doc_on_sys: {only: :sys}]).merge(id: id)
  end
end
