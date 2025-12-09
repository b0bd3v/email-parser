# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.1'

gem 'aasm' # State machine
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.6'
gem 'redis', '~> 5.0'
gem 'sidekiq'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Faraday gem for making HTTP requests
gem 'faraday', '~> 2.14'

# Devise gem for authentication
gem 'devise', '~> 4.9'

# Pagination gem
gem 'kaminari', '~> 1.2'

# I18n gem
gem 'rails-i18n', '~> 7.0'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw mswin x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'simplecov', '~> 0.22.0'
end

group :development do
  gem 'annotate', '~> 3.2'
  gem 'i18n-tasks', '~> 1.1'
  gem 'rubocop', '~> 1.81'
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem 'rack-mini-profiler'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
end
