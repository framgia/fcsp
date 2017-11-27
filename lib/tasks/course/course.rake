namespace :db do
  desc "Create course"
  task course: :environment do
    user = User.create! email: "tran.tuan.nghia@framgia.com",
      name: "Tran Tuan Nghia",
      password: "123456"

    InfoUser.create! user_id: user.id, introduction: "humman development",
      ambition: "become to rich man", quote: "human", phone: "123456789",
      birthday: "1996-11-05", occupation: "student", gender: "male"

    ProgrammingLanguage.create! name: "Ruby"
    ProgrammingLanguage.create! name: "PHP"

    courses = [
      {
        name: "[KN] Ruby on Rails 03/10/2016", start_date: "2016-10-03",
        end_date: "2016-11-11", status: "finished",
        description:  "training ruby in two months",
        language: "Ruby"
      },
      {
        name: "PHP 03/11/2016", start_date: "2016-11-03",
        end_date: "2016-11-05", status: "finished",
        description:  "training PHP in two months",
        language: "PHP"
      }
    ]

    courses.each do |course|
      programming_language = ProgrammingLanguage.find_by name: course[:language]

      course_create = Course.create! name: course[:name],
        start_date: course[:start_date],
        end_date: course[:end_date],
        status: course[:status],
        programming_language_id: programming_language.id,
        description: course[:description]

      UserCourse.create! user_id: user.id, course_id: course_create.id
    end
  end
end
