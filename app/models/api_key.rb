class ApiKey < ActiveRecord::Base
  attr_accessible :access_token, :oscollect_client_description, :expires_at, :ignore_token_edits

  attr_accessor :ignore_token_edits

  def generate_token
    # ensure token is all lower case, as mysql only does case insensitive 
    # searches unless column is varbinary:
    random_token = SecureRandom.urlsafe_base64(32, false).downcase
    loop do
      break unless ApiKey.where(access_token: random_token).exists?
      random_token = SecureRandom.urlsafe_base64(32, false).downcase
    end
    self.access_token = random_token
  end
end
