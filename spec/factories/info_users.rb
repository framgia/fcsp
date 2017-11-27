FactoryGirl.define do
  factory :info_user do
    relationship_status 0
    introduction FFaker::Lorem.paragraph
    birthday FFaker::Time.date
    phone FFaker::PhoneNumber.short_phone_number
    quote FFaker::Lorem.sentence
    ambition FFaker::Lorem.sentence
    address FFaker::Address.city
    occupation FFaker::Job.title
    gender "male"
    user
  end
end
