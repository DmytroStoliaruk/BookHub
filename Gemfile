# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

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
gem "elasticsearch", "~> 8.10"
gem "searchkick", "~> 5.3"

group :development, :test do

  gem "debug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 5.0"
  gem 'shoulda', '~> 4.0'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'factory_bot_rails'
  gem 'faker'

end

group :development do

  gem "web-console"

end
