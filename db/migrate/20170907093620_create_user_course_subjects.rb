class CreateUserCourseSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :user_course_subjects do |t|
      t.integer :user_id
      t.integer :course_subject_id
      t.timestamps
    end
  end
end
