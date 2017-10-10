source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

source "https://rails-assets.org" do
  gem "rails-assets-datetimepicker"
end

gem "rails", "~> 5.0.2"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "pg"
gem "config"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "devise"
gem "jquery-turbolinks"
gem "bootstrap-sass", "~> 3.3.6"
gem "ffaker"
gem "therubyracer"
gem "simple_form"
gem "gentelella-rails"
gem "carrierwave"
gem "mini_magick"
gem "cancancan"
gem "jquery-ui-rails", "~> 5.0.5"
gem "active_model_serializers"
gem "js-routes"
gem "globalize", git: "https://github.com/globalize/globalize"
gem "activemodel-serializers-xml"
gem "social-share-button", "0.8.4"
gem "ransack"
gem "rails-i18n"
gem "redcarpet"
gem "cocoon"
gem "coderay"
gem "dropzonejs-rails"
gem "paranoia"
gem "geocoder"
gem "public_activity"
gem "acts-as-taggable-on"
gem "i18n-js", ">= 3.0.0.rc11"
gem "rails-assets-sweetalert2", source: "https://rails-assets.org"
gem "sweet-alert2-rails"
gem "valid_url"
gem "roo"
gem "acts_as_follower", github: "tcocca/acts_as_follower"
gem "has_friendship"
gem "figaro"
gem "validates_timeliness"
gem "ckeditor"
gem "font-awesome-sass", "~> 4.7.0"
gem "omniauth-hrsystem",
  git: "https://github.com/framgia-education/omniauth-hrsystem.git"
gem "bootstrap-datepicker-rails"
gem "searchkick"
gem "crono"
# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 3.0"
# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

group :development, :test do
  gem "byebug", platform: :mri
  gem "pry-rails"
  gem "rack-mini-profiler", require: false
  gem "factory_girl_rails"
  gem "rspec-rails", "~> 3.5"
  gem "faker"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "bullet"
  gem "pry"
  gem "i18n_yaml_sorter"
end

group :test do
  gem "rspec-collection_matchers"
  gem "shoulda-matchers", "~> 3.0"
  gem "database_cleaner"
  gem "rubocop", "0.47.1", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "scss_lint", require: false
  gem "scss_lint_reporter_checkstyle", require: false
  gem "rails_best_practices"
  gem "brakeman", require: false
  gem "eslint-rails", git: "https://github.com/octoberstorm/eslint-rails"
  gem "bundler-audit"
  gem "reek"
  gem "rails-controller-testing"
  gem "simplecov", require: false
  gem "rspec-activemodel-mocks"
  gem "webmock"
  gem "capybara"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
