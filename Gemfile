# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '~> 1.4', require: false
gem 'pg', '~> 1.2'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0'
gem 'rswag', '~> 2.4'

group :development, :test do
  gem 'dotenv-rails', '~> 2.7'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.1'
  gem 'lefthook', '~> 0.7', require: false
  gem 'pronto', '~> 0.11', require: false
  gem 'pronto-rubocop', '~> 0.11', require: false
  gem 'pry-byebug', '~> 3.9'
  gem 'pry-rails', '~> 0.3'
  gem 'rspec-rails', '~> 5.0'
  gem 'rubocop', '~> 1.2', require: false
  gem 'rubocop-performance', '~> 1.1', require: false
  gem 'rubocop-rails', '~> 2.1', require: false
  gem 'rubocop-rspec', '~> 2.5', require: false
end

group :development do
  gem 'annotate', '~> 3.1'
  gem 'listen', '~> 3.2'
  gem 'spring', '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0'
end

group :test do
  gem 'climate_control', '~> 1.0'
  gem 'shoulda-matchers', '~> 5.0'
end

gem 'tzinfo-data', '~> 1.2', platforms: %i[mingw mswin x64_mingw jruby]
