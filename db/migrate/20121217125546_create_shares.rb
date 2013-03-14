class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references  :user
      t.string      :share_token # unique
      t.string      :name
      # search/search_fields, chart, alert, dashboard/widgets, or report:
      t.string      :share_type
      t.text        :share_as_json
      t.text        :description
      t.timestamps
    end
  end
end