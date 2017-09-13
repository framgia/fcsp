class CreateUserSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :user_schools do |t|
      t.integer :user_id
      t.integer :school_id
      t.integer :degree
      t.text :major
      t.datetime :start_date
      t.datetime :end_date
      t.integer :complete
      t.text :type_of_graduation
    end
  end
end
