class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :website
      t.text :introduction
      t.string :founder
      t.integer :company_size
      t.string :country
      t.date :founder_on

      t.timestamps
    end
    add_index :companies, :name
    add_index :companies, :website
  end
end
