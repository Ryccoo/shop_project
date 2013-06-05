# encoding: UTF-8
class User < ActiveRecord::Base

  has_many  :user_comments, :dependent => :destroy

  attr_accessor :password, :kraj, :old_password, :pass_change
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :kraj, :city, :description, :old_password, :pass_change
  validates :email,       :presence => :true,
  										    :uniqueness => :true

  validates :password,    :presence => :true,
                          :confirmation => :true,
                          :if => :pass_required,
                          :if => :not_fb_user,
                          :length => { :minimum => 8}
  
  validates :first_name,  :presence => :true
  
  validates :last_name,   :presence => :true

  before_save do |model|
    encrypt_password
    set_country
    if pass_change
      update_pass
    end
    #pokial nemal skupinu == je novy
    unless(self.group)
      self.group="user"
    end
  end

  def update_pass
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def set_country
    if kraj 
      data = kraj.split("^")
      self.region=data[1]
      if data[0]=="SR"
        self.country="Slovenská republika"
      elsif data[0]=="CZ"
        self.country="Česká republika"
      end
    end
  end

  def pass_required
    self.new_record? or pass_change
  end

  def not_fb_user
    if self.provider=="facebook"
      return false
    end
    return true
  end


  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
  	user = User.find_by_email(email)

  	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  		return user
  	else
  		return nil
  	end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      # user.name = auth.info.name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.oauth_token = auth.credentials.token
      user.email = auth.info.email
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.password_salt = BCrypt::Engine.generate_salt
      user.save!
  end
end

end