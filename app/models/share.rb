class Share < ActiveRecord::Base
  attr_accessible :name, :share_token, :share_type, :share_as_json, :description

  before_create :generate_token

  protected

  def generate_token
    random_token = SecureRandom.urlsafe_base64(32, false)
    loop do
      break unless Share.where(share_token: random_token).exists?
      random_token = SecureRandom.urlsafe_base64(32, false)
    end
    self.share_token = random_token
  end
end
