FactoryGirl.define do
  factory :user, class: User do |f|
    f.email FFaker::Internet.email
    f.password FFaker::Internet.password
  end
end
