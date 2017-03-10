class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.integer :company_id
      t.string :title
      t.string :describe
      t.integer :type_of_candidates
      t.integer :who_can_apply

      t.timestamps
    end
  end
end
