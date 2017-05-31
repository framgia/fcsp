class AddTimeShowToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :time_show, :datetime
  end
end
