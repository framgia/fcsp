class CreateUserSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :user_schools do |t|
      t.integer :user_id
      t.integer :school_id
      t.string :degree
      t.string :major
      t.date :graduation
      t.text :description
      t.string :address
    end
  end
end
