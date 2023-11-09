source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.8"

gem "sprockets-rails"

gem "pg", "~> 1.1"

gem "puma", "~> 5.0"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "tailwindcss-rails"

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "bootsnap", require: false

# Additional gems
gem "devise"
gem "simple_form"
gem "elasticsearch-model"
gem "elasticsearch-rails"


group :development, :test do
  gem "debug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
end

group :test do
  gem "rspec-rails", "~> 5.0"
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem "shoulda", "~> 4.0"
  gem "shoulda-matchers", "~> 4.0"
end

group :development do
  gem "web-console"
end
