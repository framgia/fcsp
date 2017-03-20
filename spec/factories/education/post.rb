FactoryGirl.define do
  factory :education_post, class: Education::Post do |f|
    f.title{FFaker::Lorem.sentence}
    f.content{FFaker::Lorem.paragraph 1}
    f.category{Education::Category.first || association(:education_category)}
    f.user{User.first || association(:user)}
  end

  factory :education_post_with_title, class: Education::Post do |f|
    f.title{"Curabitur non nulla sit amet nisl tempus convallis quis ac lectus"}
    f.content{FFaker::Lorem.paragraph 1}
    f.category{Education::Category.first || association(:education_category)}
    f.user{User.first || association(:user)}
  end

  factory :education_post_with_content, class: Education::Post do |f|
    f.title{FFaker::Lorem.sentence}
    f.content{"Donec rutrum congue leo eget malesuada.
      Donec sollicitudin molestie malesuada. Vivamus magna justo,
      lacinia eget consectetur sed, convallis at tellus."}
    f.category{Education::Category.first || association(:education_category)}
    f.user{User.first || association(:user)}
  end
end
