source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'mysql2'
gem 'puma', '~> 3.0'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'

group :development, :test do
  gem 'pry-rails'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # gem 'spring' # I don't even like spring, but it's incompatible with gems.rb at 2.0.2 for the moment
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
end

group :production do
  gem 'therubyracer'
  gem 'unicorn'
end
