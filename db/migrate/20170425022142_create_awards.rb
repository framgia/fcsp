class CreateAwards < ActiveRecord::Migration[5.0]
  def change
    create_table :awards do |t|
      t.string :name
      t.string :time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
