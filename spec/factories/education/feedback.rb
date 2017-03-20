FactoryGirl.define do
  factory :education_feedback, class: Education::Feedback do |f|
    f.name{FFaker::Name.name}
    f.email{FFaker::Internet.email}
    f.phone_number{FFaker::PhoneNumber.phone_number}
    f.subject{FFaker::Lorem.sentence}
    f.content{FFaker::Lorem.paragraph 1}
  end
end
