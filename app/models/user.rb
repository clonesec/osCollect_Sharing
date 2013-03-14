class User < ActiveRecord::Base
  has_many :searches, dependent: :destroy
  # has_many :alerts, dependent: :destroy
  # has_many :charts, dependent: :destroy
  # has_many :dashboards, dependent: :destroy
  # has_many :reports, dependent: :destroy

  attr_accessible :email, :oscollect_username, :oscollect_user_id

  before_create :generate_access_token

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
