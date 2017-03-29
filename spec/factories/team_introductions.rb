FactoryGirl.define do
  factory :team_introduction do
    team_target_id 1
    team_target_type "company"
    title{FFaker::Lorem.sentence}
    content{FFaker::Lorem.paragraph}
  end
end
