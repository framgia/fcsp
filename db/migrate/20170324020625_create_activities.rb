# Migration responsible for creating a table with activities
class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :name
      t.string :organization
      t.string :description
      t.string :address
      t.string :url
      t.string :type
      t.string :license_number
      t.datetime :time_start
      t.datetime :time_end
    end
  end
end
