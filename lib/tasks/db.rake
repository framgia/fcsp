require "ffaker"

namespace :db do
  desc "Seeding data"
  task seeding: :environment do
    if Rails.env.production?
      puts "Do not running in 'Production' task"
    else
      %w[db:drop db:create db:migrate db:seed].each do |task|
        Rake::Task[task].invoke
      end

      puts "Create companies"
      companies = {
        "Framgia VietNam": "Kobayashi Taihei",
        "FPT software": "Hoang Nam Tien",
        "BraveBits": "Alex Ferguson",
        "VC Corp": "Vuong Vu Thang",
        "Ipcoms": "Vu Minh Tuan"
      }

      companies.each do |name, founder|
        introduction = FFaker::Lorem.sentence
        website = FFaker::Internet.domain_name
        company_size = 100
        founder_on = FFaker::Time.datetime
        Company.create(name: name,
          introduction: introduction,
          website: website,
          founder: founder,
          company_size: company_size,
          founder_on: founder_on)
      end

      puts "Create users"
      users = {
        "hoang.thi.nhung@framgia.com": "nhunghoang",
        "do.ha.long@framgia.com": "longdh",
        "do.van.nam@framgia.com": "namdv",
        "nguyen.ha.phan@framgia.com": "phannh",
        "luu.thi.thom@framgia.com": "thomlt"
      }

      users.each do |email, password|
        User.create(name: FFaker::Name.name, email: email, password: password)
      end

      puts "Create groups"
      groups = ["Education", "HR", "BO"]
      groups.each do |group|
        company_id = 2
        description = FFaker::Lorem.sentence
        Group.create! name: group,
          company_id: company_id,
          description: description
      end
      puts "Create Education projects"
      Rake::Task["education:make_projects"].invoke

      puts "Create Education trainings"
      Rake::Task["education:make_trainings"].invoke

      puts "Create Education categories"
      Rake::Task["education:make_categories"].invoke

      puts "Create Education posts"
      Rake::Task["education:make_posts"].invoke
    end
  end
end
