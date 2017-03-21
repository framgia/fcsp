class CreateTeamIntroductions < ActiveRecord::Migration[5.0]
  def change
    create_table :team_introductions do |t|
      t.integer :team_target_id
      t.string :team_target_type
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
