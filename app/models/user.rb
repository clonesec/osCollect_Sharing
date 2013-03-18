class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :username, :email, :password, :password_confirmation

  validates :email, presence: true, 
            uniqueness: {case_sensitive: false},
            length: {minimum: 3},
            format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :username, presence: true, 
            uniqueness: {case_sensitive: false},
            length: {minimum: 3}
  validates :password, presence: true, length: {minimum: 6}, on: :create
  validates :password, presence: true, length: {minimum: 6}, on: :update, :if => :password_digest_changed?

  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self.id).deliver
  end
end
