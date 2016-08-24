class PdsEngineer < ActiveRecord::Base
  # attr_accessible :login_project
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable

  # def login_project=(value)
  #   @login_project=value
  # end

  attr_reader :login_project

  # def self.login_project
  #   byebug
  #   @login_project
  # end

  def valid_password?(password)
    #      logger.info " #{password}"
    #      puts password
    #      puts encrypted_password
    #      puts Digest::SHA1.hexdigest(password).class
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
