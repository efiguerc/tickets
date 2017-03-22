source 'https://rubygems.org'
ruby '2.3.3'

# Loading dotenv as early as possible
  gem 'dotenv', require: './config/dotenv'

# CORE STUFF
  gem 'rails', '~> 5.0.2'
  gem 'mysql2', '>= 0.3.18', '< 0.5'
  gem 'puma', '~> 3.0'
  gem 'devise'
  gem 'active_model_serializers', '~> 0.10.0'

# GENERAL USAGE GEMS
  gem "paranoia", "~> 2.2"

# ASSETS, FRONTEND, TEMPLATING, ETC
  gem 'bootstrap-sass', '~> 3.3.6'
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.2'
  gem 'jquery-rails'
  gem 'turbolinks', '~> 5'
  gem 'jbuilder', '~> 2.5'
  gem 'react-rails'
  # gem 'therubyracer', platforms: :ruby
  # gem 'redis', '~> 3.0'
  # gem 'bcrypt', '~> 3.1.7'

# DEPLOYMENT TOOLS
  # gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard', '~> 1.6.1'
  gem 'pry-rails'
end

group :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'shoulda-matchers', '~> 3.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
