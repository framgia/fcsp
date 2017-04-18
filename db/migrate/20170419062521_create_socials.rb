class CreateSocials < ActiveRecord::Migration[5.0]
  def change
    create_table :socials do |t|
      t.string :name
      t.string :url
      t.string :social_type
      t.integer :target_id
      t.string :target_type

      t.timestamps
    end
  end
end
