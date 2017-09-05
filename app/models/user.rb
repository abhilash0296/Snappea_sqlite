require 'securerandom'
class User < ActiveRecord::Base
  has_secure_password  
  before_create :set_auth_token
    
  def self.get_login_api username,password
    User.find_by(email: username).try(:authenticate, password)
  end      

  private  
  
  def set_auth_token
    return if api_key.present?
    self.api_key = generate_api_key
  end

  def generate_api_key
    SecureRandom.uuid.gsub('-','').upcase
  end  
end
