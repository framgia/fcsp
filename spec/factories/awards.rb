FactoryGirl.define do
  factory :award do
    name{FFaker::Company.name}
    time "2017"
    user
  end
end
