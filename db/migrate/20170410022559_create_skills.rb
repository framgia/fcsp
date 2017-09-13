class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.integer :group_skill_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
