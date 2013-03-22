class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.string      :email
      t.string      :share_origin # host:port
      t.string      :share_token # unique
      t.string      :name
      # search/search_fields, chart, alert, dashboard/widgets, or report:
      t.string      :share_type
      t.text        :share_as_json
      t.text        :description
      t.timestamps
    end
    add_index :shares, :share_token
  end
end
