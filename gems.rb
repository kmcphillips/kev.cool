source 'https://rubygems.org'

gem 'rails', '~> 5.2.0'
gem 'mysql2'
gem 'puma'
gem 'bootsnap'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # gem 'spring' # I don't even like spring, but it's incompatible with gems.rb at 2.0.2 for the moment
  gem 'capistrano', '3.6.1'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
end

group :production do
  gem 'therubyracer'
end
