class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.integer :programming_language_id
      t.string :name
      t.integer :status
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
