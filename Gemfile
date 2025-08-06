source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "active_storage_validations"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "bootstrap-sass", "~> 3.4.1"
gem "faker"
gem "image_processing", "~> 1.2"
gem "jbuilder"
gem "jquery-rails", "~> 4.6"
gem "mysql2", "~> 0.5"
gem "pagy", "~> 6.0"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.5"
gem "rails-i18n", "~> 7.0.0"
gem "sassc-rails", "~> 2.1.2"
gem "sprockets-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html
  gem "debug", platforms: %i(mri mingw x64_mingw)
  gem "dotenv-rails"
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
