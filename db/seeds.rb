require "ffaker"

puts "Create Trainees"
trainees = {
  "duong.huu.nam@framgia.com.stg": "Duong Huu Nam",
  "tran.duc.anh@framgia.com.stg": "Tran Duc Anh",
  "dang.khac.toan@framgia.com.stg": "Dang Khac Toan",
  "chu.kim.thang@framgia.com": "Chu Kim Thang",
  "bui.khanh.huyen@framgia.com": "Bui Khanh Huyen",
}

admin = User.create! name: "Admin",
  password: "123456",
  email: "admin@framgia.stg.com"

trainees.each do |email, name|
  trainee = User.create! name: name,
    email: email,
    password: "123456",
    role: "trainee"

  InfoUser.create! user_id: trainee.id,
    introduction: "I am a Ruby developer and have many years of experience in working
      for training and developing web programming. With continuous learning ability,
      effective problem solving and communication skills, I have been always
      trying to create something awesome!",
    address: "Ha Noi, Viet Nam",
    phone: "0902890890"
    birthday: "01/01/1980"
end

InfoUser.create! user_id: admin.id,
  introduction: "I am admin",
  address: "Da Nang, Viet Nam",
  phone: "123456789"

puts "Create skills"
6.times do
  Skill.create name: FFaker::Skill.tech_skill
end

puts "Assign skill to user"
User.all.each do |user|
  skills = Skill.order("Random()").limit(2).pluck :id
  skills.each do |skill|
    SkillUser.create! user_id: user.id, skill_id: skill,
    years: rand(1..3)
  end
end

puts "create default course of user"
user = User.create! email: "nguyen.thi.huong@framgia.com.stg",
  name: "Nguyen Thi Huong",
  password: "123456"

InfoUser.create! user_id: user.id,
  introduction: "I am a Ruby developer and have many years of experience in working
    for training and developing web programming. With continuous learning ability,
    effective problem solving and communication skills, I have been always
    trying to create something awesome!",
  quote: "I have been always trying to create something awesome!",
  phone: "0968890890",
  birthday: "1994-09-08",
  occupation: "IT engineer",
  gender: "female",
  address: "Thieu Van, Thieu Hoa, Thanh Hoa",
  country: "Viet Nam",
  relationship_status: "single"

programming_language = ProgrammingLanguage.create! name: "Ruby"

course = {
  name: "[KN] Ruby on Rails 03/10/2016",
  start_date: "2016-10-03",
  end_date: "2016-11-11", status: "finished",
  description:  "Training Ruby on Rails for Internships, who has two months to
    complete training program. After this course, they have background knowledge
    about Ruby language and Rails framework, programming Web application RoR."
}

course_create = Course.create! name: course[:name],
  start_date: course[:start_date],
  end_date: course[:end_date],
  status: course[:status],
  programming_language_id: programming_language.id,
  description: course[:description]

UserCourse.create! user_id: user.id, course_id: course_create.id

puts "create default subject of user"
subjects = [
  {
    name: "Git Tutorial",
    subject_description: "Start Git for your project today.\r\n",
    subject_content: "<p>Get an introduction to github, code version management</p>\r\n",
    status: "finished",
    start_date: "2016-10-03",
    end_date: "2016-10-05"
  },
  {
    name: "Ruby on Rails Tutorial Book",
    subject_description: "Learn the basic building blocks of Ruby, all in the browser.\r\n",
    subject_content: "<p><strong>Tài liệu học tập</strong>:</p>\r\n<p>[Coding Convention]&nbsp;</p>\r\n<p><a href=\"https://github.com/framgia/coding-standards/blob/master/vn/README.md \" target=\"_blank\">https://github.com/framgia/coding-standards/blob/master/vn/README.md </a>&nbsp;</p>\r\n<p>[Ruby tutorial book]  <a href=\"https://raw.githubusercontent.com/jay3126/various_imp_ebooks/master/the_ruby_programming_language.pdf\" target=\"_blank\">https://raw.githubusercontent.com/jay3126/various_imp_ebooks/master/the_ruby_programming_language.pdf</a>&nbsp;</p>\r\n<p>[Rails tutorial in 8 days]&nbsp;</p>\r\n<p><a href=\"https://www.railstutorial.org/book\" target=\"_blank\">https://www.railstutorial.org/book</a> (rails 5)&nbsp;&nbsp;</p>\r\n<p><a href=\"http://3rd-edition.railstutorial.org/book\" target=\"_blank\">http://3rd-edition.railstutorial.org/book</a> (rails 4)&nbsp;</p>\r\n<p></p>\r\n<p>[CI Introduction]</p>\r\n<p>https://www.canva.com/design/DACZmRTQy2E/nj4j049y0GKFj_MJdcuObQ/edit</p>\r\n",
    status: "finished",
    start_date: "2016-10-05",
    end_date: "2016-12-15"
  },
  {
    name: "Ruby's Project 1",
    subject_description: "Start Project 1 for Ruby on Rails today.\r\n",
    subject_content: "<p>[List of techniqes are Rails Advance]\t\t\t</p>\r\n<p>&nbsp;[Rails Advance 1]&nbsp;</p>\r\n<p>1. Nested Attribute (fields_for, reject_if, allow_destroy, ...)&nbsp;</p>\r\n<p>2. Batch Update&nbsp;</p>\r\n<p>3. Form_for&nbsp;</p>\r\n<p>4. Call back function&nbsp;</p>\r\n<p>5. Macro (generate, rake, spring, ...)&nbsp;</p>\r\n<p>6. Ajax (Rails ajax, jQuery ajax)&nbsp;</p>\r\n<p>7. Seed&nbsp;</p>\r\n<p>8. RESTful (<a href=\"http://www.infoq.com/articles/rest-introduction\" target=\"_blank\">http://www.infoq.com/articles/rest-introduction</a> )&nbsp;&nbsp;</p>\r\n<p>9. Association (has_many/has_one/belongs_to)&nbsp;</p>\r\n<p>10. Transaction&nbsp;</p>\r\n<p>11. Resources, Nested Resources&nbsp;</p>\r\n<p>12. Resource&nbsp;</p>\r\n<p>13. Export CSV, Excel&nbsp;</p>\r\n<p>14. Rake task&nbsp;</p>\r\n<p>15. CSRF Protection&nbsp;</p>\r\n<p>16. Coffee&nbsp;</p>\r\n<p>17. Concerns&nbsp;</p>\r\n<p>18. Scope&nbsp;</p>\r\n<p>19. I18n (mutil language, dictionary, time format, number format, ...)&nbsp;</p>\r\n<p>20. Search form, filter form&nbsp;</p>\r\n<p>21. Gem Config (<a href=\"https://github.com/railsconfig/config\" target=\"_blank\">https://github.com/railsconfig/config</a> )&nbsp;</p>\r\n<p>22. Eager Loading Associations&nbsp;</p>\r\n<p>23. Validation&nbsp;</p>\r\n<p>24. Environment Variable&nbsp;</p>\r\n<p>25. MVC&nbsp;</p>\r\n<p>26. Module mixin&nbsp;</p>\r\n<p>27. Proc / Lambda&nbsp;</p>\r\n<p>28. Debug Javascipt code&nbsp;</p>\r\n<p>29. Jquery selector&nbsp;</p>\r\n<p>30. CSS selector&nbsp;</p>\r\n<p>31. Ruby Nil Object&nbsp;</p>\r\n<p>[Rails Advance 2]&nbsp;</p>\r\n<p>1. Gem Devise&nbsp;</p>\r\n<p>2. Gem CanCanCan&nbsp;</p>\r\n<p>3. Gem Ransack&nbsp;</p>\r\n<p>4. Background job: sidekiq, resque&nbsp;</p>\r\n<p>5. Cronjob: whenever, delayed job&nbsp;</p>\r\n<p>6. Unit Test (Rspec)&nbsp;</p>\r\n<p>7. Metaprogramming (send, eval, class_eval, ...)&nbsp;</p>\r\n<p>8. Authenticate via Facebook, Twitter, Google&nbsp;</p>\r\n<p>9. Social button share (<a href=\"https://github.com/huacnlee/social-share-button\" target=\"_blank\">https://github.com/huacnlee/social-share-button</a> )&nbsp;</p>\r\n<p>10. Gem paranoia (<a href=\"https://github.com/rubysherpas/paranoia\" target=\"_blank\">https://github.com/rubysherpas/paranoia</a> )&nbsp;</p>\r\n<p>11. Gem public_activity&nbsp;</p>\r\n<p>12. Simple form (<a href=\"https://github.com/plataformatec/simple_form\" target=\"_blank\">https://github.com/plataformatec/simple_form</a> )&nbsp;</p>\r\n<p>13. Kaminari (<a href=\"https://github.com/amatsuda/kaminari\" target=\"_blank\">https://github.com/amatsuda/kaminari</a> )&nbsp;</p>\r\n<p>14. Friendly_id (<a href=\"https://github.com/norman/friendly_id\" target=\"_blank\">https://github.com/norman/friendly_id</a> )&nbsp;</p>\r\n<p>15. Chatwork (<a href=\"https://github.com/asonas/chatwork-ruby\" target=\"_blank\">https://github.com/asonas/chatwork-ruby</a> )</p>\r\n",
    status: "finished",
    start_date: "2016-11-22",
    end_date: "2017-02-08"
  },
  {
    name: "Ruby's Project 2",
    subject_description: "Start Project 2 for Ruby on Rails today.\r\n",
    subject_content: "<p>[Rails Advance 3]&nbsp;</p>\r\n<p>1. API&nbsp;</p>\r\n<p>2. Haml (https://github.com/haml/haml)&nbsp;</p>\r\n<p>3. WebSocket&nbsp;</p>\r\n<p>4. Form Object&nbsp;</p>\r\n<p>5. Service Object&nbsp;</p>\r\n<p>6. Query Object&nbsp;</p>\r\n<p>7. Caching&nbsp;&nbsp;</p>\r\n<p>8. Fulltext search&nbsp;</p>\r\n<p>9. Pretty URL</p>\r\n",
    status: "finished",
    start_date: "2017-02-08",
    end_date: "2017-03-08"
  }
]

course = Course.find_by name: "[KN] Ruby on Rails 03/10/2016"
user = User.find_by email: "nguyen.thi.huong@framgia.com.stg"

subjects.each do |subject|
  subject_created = Subject.create! name: subject[:name],
    description: subject[:subject_description],
    content: subject[:content]

  UserCourseSubject.create! user_id: user.id,
    course_id: course.id,
    subject_id: subject_created.id,
    start_date: subject[:start_date],
    end_date: subject[:end_date],
    status: subject[:status],
    content: "Basic for work!"
end

puts "create default subject of user"
tasks = [
  {
    user_email: "nguyen.thi.huong@framgia.com.stg",
    subject_name: "Git Tutorial",
    course_name: "[KN] Ruby on Rails 03/10/2016",
    data: [
      {
        name: "Getting Started",
        status: "in_progress",
        content: "Get an introduction to project git",
        task_type: "assignments"
      },
      {
        name: "Git Branching",
        status: "in_progress",
        content: "Get an introduction to project git",
        task_type: "assignments"
      },
      {
        name: "Distributed Git",
        status: "in_progress",
        content: "Get an introduction to project git",
        task_type: "assignments"
      },
      {
        name: "GitHub",
        status: "init",
        content: "Get an introduction to project git",
        task_type: "assignments"
      },
      {
        name: "Git Tools",
        status: "init",
        content: "Get an introduction to project git",
        task_type: "assignments"
      },
      {
        name: "Customizing Git",
        status: "init",
        content: "Get an introduction to project git",
        task_type: "assignments"
      }
    ]
  },
  {
    user_email: "nguyen.thi.huong@framgia.com.stg",
    subject_name: "Ruby's Project 1",
    course_name: "[KN] Ruby on Rails 03/10/2016",
    data: [
      {
        name: "Requirement understanding",
        status: "init",
        content: "Get an introduction to project understanding",
        task_type: "assignments"
      },
      {
        name: "Design Database",
        status: "in_progress",
        content: "Start design database",
        task_type: "assignments"
      },
      {
        name: "Localization",
        status: "init",
        content: "Introduces the concepts and techniques of internationalization and localization.",
        task_type: "assignments"
      },
      {
        name: "UserDefaults",
        status: "in_progress",
        content: "Use NSUserDefaults to save user preferences in a persistent manner.",
        task_type: "assignments"
      }
    ]
  }
]

tasks.each do |task|
  user = User.find_by email: task[:user_email]
  subject = Subject.find_by name: task[:subject_name]
  course = Course.find_by name: task[:course_name]

  task[:data].each do |data|
    task_created = Task.create! name: data[:name],
      subject_id: subject.id,
      task_type: data[:task_type],
      description: data[:content],
      content: data[:content]

    UserTask.create! user_id: user.id,
      task_id: task_created.id,
      subject_id: subject.id,
      course_id: course.id,
      status: data[:status]
  end
end
