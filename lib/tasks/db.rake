require "ffaker"

namespace :db do
  desc "Seeding data"
  task seeding: :environment do
    if Rails.env.production?
      puts "Do not running in 'Production' task"
    else
      %w[db:drop db:create db:migrate].each do |task|
        Rake::Task[task].invoke
      end

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
        email: "admin@framgia.com.stg"

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
      end

      InfoUser.create! user_id: admin.id,
        introduction: "I am admin",
        address: "Da Nang, Viet Nam",
        phone: "123456789"

      puts "create data course default for trainee"
      Rake::Task["db:course"].invoke
      Rake::Task["db:subject"].invoke
      Rake::Task["db:task"].invoke

      puts "Create skills"
      skills = ["Mysql", "Ruby", "PHP", "Android", "Javascript", "Python"]

      skills.each do |skill|
        Skill.create! name: skill
      end

      puts "Assign skill to user"
      User.all.each do |user|
        skills = Skill.order("RAND()").limit(2).pluck(:id)
        skills.each do |skill|
          SkillUser.create! user_id: user.id, skill_id: skill,
          years: rand(1..3)
        end
      end

      puts "Create language"

      languages = ["English", "Japan", "Chinese", "Vietnamese", "Thai"]

      languages.each do |language|
        Language.create! name: language
      end

      puts "Assign language to trainee"

      User.trainee.each do |trainee|
        language_ids = Language.order("RAND()").limit(3).pluck :id
        language_ids.each do |language|
          UserLanguage.create! user_id: trainee.id, language_id: language,
            level: rand(0..2)
        end
      end
    end
  end
end
