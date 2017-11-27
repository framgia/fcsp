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

      puts "Create companies"
      companies = {
        "FPT software": "Hoang Nam Tien",
        "BraveBits": "Alex Ferguson",
        "VC Corp": "Vuong Vu Thang",
        "Ipcoms": "Vu Minh Tuan"
      }

      default_user = User.create! name: "Hoang Thi Nhung",
        email: "hoang.thi.nhung@framgia.com",
        password: "123456",
        role: "employer"

      default_company = Company.create! name: "Framgia VietNam",
        introduction: FFaker::Lorem.paragraph,
        website: FFaker::Internet.domain_name,
        founder: "Kobayashi Taihei",
        company_size: 100, founder_on: FFaker::Time.datetime,
        creator_id: default_user.id

      InfoUser.create! user_id: default_user.id,
        introduction: Faker::Lorem.paragraph,
        address: "Ha Noi, Viet Nam",
        phone: "0123456789",
        birthday: "1990-01-01",
        occupation: "student",
        gender: "male"

      companies.each do |name, founder|
        Company.create! name: name, introduction: FFaker::Lorem.paragraph,
          website: FFaker::Internet.domain_name, founder: founder,
          company_size: 100, founder_on: FFaker::Time.datetime
      end

      puts "Create users"
      users = {
        "do.ha.long@framgia.com": "Do Ha Long",
        "luu.thi.thom@framgia.com": "Luu Thi Thom",
        "thuy.viet.quoc@framgia.com": "Thuy Viet Quoc",
        "tran.anh.vu@fsramgia.com": "Tran Anh Vu",
        "le.quang.canh@sframgia.com": "Le Quang Anh",
        "user@gmail.com": "User",
        "ttkt1994@gmail.com": "User",
      }

      users.each do |email, name|
        user = User.create! name: name, email: email, password: "123456"
        InfoUser.create! user_id: user.id, introduction: FFaker::Lorem.paragraph,
          address: "Da Nang, Viet Nam",
          phone: FFaker::PhoneNumber.short_phone_number,
          birthday: FFaker::Time.date, occupation: "student", gender: "male"
      end

      trainees = {
        "do.van.nam@framgia.com": "Do Van Nam",
        "nguyen.ha.phan@framgia.com": "Nguyen Ha Phan",
        "nguyen.ngoc.thinh@framgia.com": "Nguyen Ngoc Thinh",
        "tran.xuan.nam@framgia.com": "Tran Xuan Nam",
        "chu.kim.thang@framgia.com": "Chu Kim Thang",
        "bui.khanh.huyen@framgia.com": "Bui Khanh Huyen",
        "sonnguyenngoc1604@gmail.com": "Nguyen Ngoc Son"
      }

      trainees.each do |email, name|
        trainee = User.create! name: name, email: email, password: "123456",
          role: "trainee"
        InfoUser.create! user_id: trainee.id,
          address: "Da Nang, Viet Nam",
          phone: FFaker::PhoneNumber.short_phone_number,
          birthday: FFaker::Time.date, occupation: "student", gender: "male",
          introduction: "i want become to development and help all people in the world!!"
      end

      puts "create data course default for trainee"
      Rake::Task["db:course"].invoke
      Rake::Task["db:subject"].invoke
      Rake::Task["db:task"].invoke

      edu_admin = User.create! name: "Education admin",
        password: "123456",
        email: "admin.education@framgia.com"
      InfoUser.create! user_id: edu_admin.id, introduction: FFaker::Lorem.paragraph,
        address: "Da Nang, Viet Nam",
        phone: FFaker::PhoneNumber.short_phone_number,
        birthday: FFaker::Time.date, occupation: "student", gender: "male"

      user = User.create! name: "Adminprp",
        email: "admin@gmail.com",
        password: "123456",
        role: "admin"
      InfoUser.create! user_id: user.id, introduction: FFaker::Lorem.paragraph,
        address: "Da Nang, Viet Nam",
        phone: FFaker::PhoneNumber.short_phone_number,
        birthday: FFaker::Time.date, occupation: "student", gender: "male"

      puts "Create jobs"
      Rake::Task["db:job"].invoke

      puts "Create Candidate"
      users = User.limit(20).pluck(:id)
      users.each do |candidate|
        jobs = Job.order("Random()").limit(20).pluck :id
        interested_in = [:have_a_chat, :work_together, :opportunity].shuffle.first
        process = [:apply, :fail_test, :joined , :pass_test, :wait_test].shuffle.first
        jobs.each do |job|
          Candidate.create! user_id: candidate, job_id: job,
            interested_in: interested_in, process: process
        end
      end

      puts "Update counter cache candidate"
      Job.all.each do |job|
        Job.update_counters job.id, candidates_count: job.candidates.length
      end

      puts "Create employee of company"
      User.all.each do |user|
        Employee.create! user_id: user.id, company_id: 1,
          description: FFaker::Lorem.sentence
      end

      puts "Create addresses of company"
      Company.all.each do |company|
        Address.create! company_id: company.id,
          address: FFaker::Address.city,
          head_office: 1
      end

      puts "Create skills"
      skills = ["Mysql", "Ruby", "PHP", "Android", "Javascript", "Python"]

      skills.each do |skill|
        Skill.create! name: skill
      end

      puts "Assign skill to user"
      User.all.each do |user|
        skills = Skill.order("Random()").limit(2).pluck(:id)
        skills.each do |skill|
          SkillUser.create! user_id: user.id, skill_id: skill,
          years: rand(1..3)
        end
      end

      puts "Create language"

      languages = ["English", "japan", "chinese", "vietnamese", "thai"]

      languages.each do |language|
        Language.create! name: language
      end

      puts "Assign language to trainee"

      User.trainee.each do |trainee|
        language_ids = Language.order("Random()").limit(3).pluck :id
        language_ids.each do |language|
          UserLanguage.create! user_id: trainee.id, language_id: language,
            level: rand(0..2)
        end
      end

      puts "Create skills are required by jobs"
      Job.all.each do |job|
        skills = Skill.order("Random()").limit(4).pluck(:id)
        skills.each do |skill|
          JobSkill.create! job_id: job.id, skill_id: skill
        end
      end

      puts "Create Employer"
      Rake::Task["db:employer"].invoke
    end
  end
end
