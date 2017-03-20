namespace :education do
  desc "create posts for education"
  task make_posts: :environment do
    30.times do |i|
      post_params = {
        title: FFaker::Lorem.sentence,
        content: FFaker::Lorem.paragraph,
        user: User.first,
        category: Education::Category.first
      }

      Education::Post.create! post_params
    end
  end
end
