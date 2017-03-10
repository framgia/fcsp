class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.integer :company_id
      t.integer :user_id
      t.string :description
      t.date :start_time
      t.integer :role
      t.integer :status

      t.timestamps
    end
  end
end
