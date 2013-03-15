class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string      :access_token
      t.datetime    :expires_at
      t.timestamps
    end
  end
end
