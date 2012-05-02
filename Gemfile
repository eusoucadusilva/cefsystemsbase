source :rubygems

gem "rails", "3.2.3"
gem "mysql2"
#gem "pg"
gem "unicorn"
gem "jquery-rails"

group :assets do
  gem "sass-rails",   "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
end

group :development do
  gem "capistrano"
  gem "capistrano_colors"
  gem "pry", :require => false
  gem "awesome_print", :require => false
end

group :development, :test do
  gem "rspec-rails"
  gem "capybara"
end

group :test do
  gem "factory_girl"
  gem "factory_girl-preload"
end
