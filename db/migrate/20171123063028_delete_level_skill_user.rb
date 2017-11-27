class DeleteLevelSkillUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :skill_users, :level
  end
end
