FactoryGirl.define do
  factory :education_category, class: Education::Category do |f|
    f.name FFaker::Name.name
  end
end
