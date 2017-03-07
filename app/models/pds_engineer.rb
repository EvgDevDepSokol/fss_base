class PdsEngineer < ActiveRecord::Base
  # attr_accessible :login_project
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable

  alias_attribute :id, self.primary_key
  has_many :pds_documents, dependent: :restrict_with_error, foreign_key: 'Author'
  has_many :pds_documents, dependent: :restrict_with_error, foreign_key: 'CheckOutEn'
  has_many :pds_documents, dependent: :restrict_with_error, foreign_key: 'CheckOutRu'
  has_many :pds_dr, dependent: :restrict_with_error, foreign_key: 'closedBy'
  has_many :pds_dr, dependent: :restrict_with_error, foreign_key: 'drAuthor'
  has_many :pds_dr, dependent: :restrict_with_error, foreign_key: 'replyAuthor'
  has_many :pds_eng_on_sys, dependent: :restrict_with_error, foreign_key: 'engineer_N'
  has_many :pds_eng_on_sys, dependent: :restrict_with_error, foreign_key: 'TestOperator_N'
  has_many :pds_project, dependent: :restrict_with_error, foreign_key: 'HWManager'
  has_many :pds_project, dependent: :restrict_with_error, foreign_key: 'SWManager'
  has_many :pds_project, dependent: :restrict_with_error, foreign_key: 'ProjectManager'
  has_many :pds_queries, dependent: :restrict_with_error, foreign_key: 'engineer_N'

  attr_reader :login_project

  def valid_password?(password)
    super(password)
  rescue BCrypt::Errors::InvalidHash
    return false unless Digest::SHA1.hexdigest(password).casecmp(encrypted_password)
    logger.info "User #{email} is using the old password hashing method, updating attribute."
    self.password = password
    true
  end

  def email
    self.EMail
  end

  def email=(v)
    self.EMail = v
  end

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
