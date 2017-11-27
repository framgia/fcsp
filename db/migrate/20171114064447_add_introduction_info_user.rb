class AddIntroductionInfoUser < ActiveRecord::Migration[5.0]
  def change
    add_column :info_users, :introduction, :string
    remove_column :info_users, :introduce
    remove_column :skill_users, :skill_id
    remove_column :skill_users, :user_id
    add_reference :skill_users, :user, foreign_key: true
    add_reference :skill_users, :skill, foreign_key: true
  end
end
