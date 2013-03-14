class ApiKeys < ActiveRecord::Base
  attr_accessible :access_token, :client_host_port, :expires_at
end
