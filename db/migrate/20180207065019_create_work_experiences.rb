class CreateWorkExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :work_experiences do |t|
      t.references :user, foreign_key: true
      t.string :organization
      t.date :date_from
      t.date :date_to
      t.string :position
      t.string :job_requirement

      t.timestamps
    end
  end
end
