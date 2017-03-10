class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.integer :company_id
      t.integer :user_id
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
