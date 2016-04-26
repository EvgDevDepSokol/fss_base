class PdsEngineer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable

  #  alias :devise_valid_password? :valid_password?

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

  #  def is_admin?
  #    CheifDirector
  #  end

  def email
    self.EMail
  end

  def email=(v)
    self.EMail = v
  end
end
