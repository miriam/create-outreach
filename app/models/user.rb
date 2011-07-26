require 'digest/sha1'

class User < ActiveRecord::Base

  email_name_regex  = '[\w\.%\+\-]+'.freeze
  domain_head_regex = '(?:[A-Z0-9\-]+\.)+'.freeze
  domain_tld_regex  = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum|coop)'.freeze
  EMAIL_REGEX       = /\A#{email_name_regex}@#{domain_head_regex}#{domain_tld_regex}\z/i
  BAD_EMAIL_MESSAGE = "is not a valid email address.".freeze

  validates_presence_of     :type

  validates_uniqueness_of   :email
  validates_length_of       :email, :maximum => 100
  validates_format_of       :email,     :with => EMAIL_REGEX, :message => BAD_EMAIL_MESSAGE

  validates_presence_of     :name
  validates_length_of       :name,    :maximum => 50, :message => "must be fewer than 50 characters"

  attr_accessor             :current_password
  attr_accessor             :password_confirmation
  attr_writer               :notification_types

  validate :validate_password_and_email

  validates_confirmation_of :password, :if => '!@invalid_password'
  
  def validate_password_and_email
    errors.add(:base, "That email address is already taken") if User.find_by_email(self.email)
    if @setting_password and !(@changing_password and password_values_nil)
      #only allow nil if all values are nil - this wont actually change password
      if @password.length < 6 || @password.length > 30
        errors.add(:base, "Password must be 6 to 30 characters") 
        @invalid_password = true
      end
    end
    
    if @changing_password and !correct_current_password 
      errors.add(:base, "The password you entered does not match your current password")
      @current_password = nil
    end
  end
  
  def current_password=(current_password)
    #If the current password is set at all (even to nil) assume the password is being changed
    @changing_password = true
    @current_password = current_password
  end
  
  def password_values_nil
    (@password.blank? and @password_confirmation.blank? and @current_password.blank?)
  end
    
  def correct_current_password
    !@current_password.nil? and User.authenticate(self.email, @current_password)
  end
  
  after_save do
    @current_password = @password = @password_confirmation = nil
    @changing_password = @setting_password = nil
  end
  
  #Password is a virtual attribute that we defined a reader and a writer for
  def password 
    @password
  end

  def password=(pwd)
    @password = pwd
    @setting_password = true
    return if pwd.length < 6 or pwd.length > 30
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
 
  def self.authenticate(email, password)
    user = self.find_by_email(email ? email.downcase : nil)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end


  private

  def self.encrypted_password(password, salt)
    string_to_hash = password + "catchphrase" + salt 
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt 
    self.salt = self.object_id.to_s + rand.to_s
  end

end

