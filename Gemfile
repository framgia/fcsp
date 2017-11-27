source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

source "https://rails-assets.org" do
  gem "rails-assets-datetimepicker"
end

gem "active_model_serializers"
gem "activemodel-serializers-xml"
gem "acts-as-taggable-on"
gem "acts_as_follower", github: "tcocca/acts_as_follower", branch: "master"
gem "bootstrap-datepicker-rails"
gem "bootstrap-kaminari-views"
gem "bootstrap-sass", "~> 3.3.6"
gem "cancancan"
gem "carrierwave"
gem "ckeditor"
gem "cocoon"
gem "coderay"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "devise"
gem "dropzonejs-rails"
gem "ffaker"
gem "figaro"
gem "font-awesome-sass", "~> 4.7.0"
gem "gentelella-rails"
gem "geocoder"
gem "globalize", git: "https://github.com/globalize/globalize"
gem "has_friendship"
gem "i18n-js", ">= 3.0.0.rc11"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "jquery-turbolinks"
gem "jquery-ui-rails", "~> 5.0.5"
gem "js-routes"
gem "kaminari"
gem "mini_magick"
gem "omniauth-hrsystem", git: "https://github.com/framgia-education/omniauth-hrsystem.git"
gem "paranoia"
gem "pg"
gem "public_activity"
gem "puma", "~> 3.0"
gem "rails", "~> 5.0.2"
gem "rails-assets-sweetalert2", source: "https://rails-assets.org"
gem "rails-i18n"
gem "rails-jquery-autocomplete"
gem "ransack"
gem "redcarpet"
gem "roo"
gem "sass-rails", "~> 5.0"
gem "searchkick"
gem "simple_form"
gem "social-share-button", "0.8.4"
gem "sweet-alert2-rails"
gem "therubyracer"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "valid_url"
gem "validates_timeliness"
group :development, :test do
  gem "byebug", platform: :mri
  gem "factory_girl_rails"
  gem "faker"
  gem "pry-rails"
  gem "rack-mini-profiler", require: false
  gem "rspec-rails", "~> 3.5"
end

group :development do
  gem "bullet"
  gem "i18n_yaml_sorter"
  gem "listen", "~> 3.0.5"
  gem "pry"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "brakeman", require: false
  gem "bundler-audit"
  gem "capybara"
  gem "chromedriver-helper"
  gem "database_cleaner"
  gem "eslint-rails", git: "https://github.com/octoberstorm/eslint-rails"
  gem "rails-controller-testing"
  gem "rails_best_practices"
  gem "reek"
  gem "rspec-activemodel-mocks"
  gem "rspec-collection_matchers"
  gem "rubocop", "0.47.1", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "scss_lint", require: false
  gem "scss_lint_reporter_checkstyle", require: false
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 3.0"
  gem "simplecov", require: false
  gem "webmock"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
