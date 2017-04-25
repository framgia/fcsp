class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios do |t|
      t.string :title
      t.string :url
      t.text :description
      t.datetime :time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
