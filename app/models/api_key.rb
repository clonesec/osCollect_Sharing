class ApiKey < ActiveRecord::Base
  attr_accessible :access_token, :oscollect_client_description, :expires_at, :ignore_token_edits

  attr_accessor :ignore_token_edits

  def generate_token
    random_token = SecureRandom.urlsafe_base64(32, false)
    loop do
      break unless ApiKey.where(access_token: random_token).exists?
      random_token = SecureRandom.urlsafe_base64(32, false)
    end
    self.access_token = random_token
  end
end
