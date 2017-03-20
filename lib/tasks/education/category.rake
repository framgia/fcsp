namespace :education do
  desc "create categories for education"
  task make_categories: :environment do
    10.times do |i|
      category_params = {
        name: Faker::Name.name
      }

      Education::Category.create! category_params
    end
  end
end
