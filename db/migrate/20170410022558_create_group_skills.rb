class CreateGroupSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :group_skills do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
