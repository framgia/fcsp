class CreateCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.integer :user_id
      t.integer :job_id
      t.integer :interested_in

      t.timestamps
    end
  end
end
