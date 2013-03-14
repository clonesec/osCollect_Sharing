class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :email # this uniquely identifies a user that is sharing
      t.string      :access_token # in lieu of password, this token allows access
      t.string      :oscollect_username
      t.integer     :oscollect_user_id # just for tracking
      t.timestamps
    end
  end
end
