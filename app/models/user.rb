require 'bcrypt'

class User

  include DataMapper::Resource

  has n, :peeps ,:through => Resource
  has n, :comments ,:through => Resource

  property :id, Serial
  property :name, String
  property :username, String, :unique => true, :message => "User name is already taken"
  property :email, String, :unique => true, :message => "Email is already registered"
  property :password_digest, Text
  property :password_token, Text
  property :password_token_timestamp, Date

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end