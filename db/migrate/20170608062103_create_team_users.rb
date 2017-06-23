class CreateTeamUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :team_users do |t|
      t.references :team, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
