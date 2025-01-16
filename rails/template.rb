# This is a template for creating new Ruby on Rails applications with pre-defined defaults.
# <https://guides.rubyonrails.org/rails_application_templates.html>
#
# New projects:
# rails new --template=~/dotfiles/rails/template.rb (can be put into ~/.railsrc)
#
# Existing projects:
# rails app:template LOCATION=~/dotfiles/rails/template.rb

gem_group :development, :test do
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop"
  gem "rubocop-factory_bot"
  gem "rubocop-obsession"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rake"
  gem "rubocop-rspec"
  gem "rubocop-rspec_rails"
  gem "rubocop-thread_safety"
  gem "ruby-lsp"
  gem "solargraph"
  gem "solargraph-rails"
end

generate "rspec:install"
rake "db:create"

run "cp ~/dotfiles/rubocop/rubocop.yml .rubocop.yml"

# Add documentation comments to core classes
inject_into_file "app/controllers/application_controller.rb", before: "class ApplicationController < ActionController::Base" do
  <<~RUBY
    # The ApplicationController is the parent controller for all controllers in the application.
    # It provides common functionality and configuration for all controllers.
    #
  RUBY
end

inject_into_file "app/helpers/application_helper.rb", before: "module ApplicationHelper" do
  <<~RUBY
    # The ApplicationHelper module provides helper methods that are available across all views.
    #
  RUBY
end

inject_into_file "app/mailers/application_mailer.rb", before: "class ApplicationMailer < ActionMailer::Base" do
  <<~RUBY
    # The ApplicationMailer is the parent mailer for all mailers in the application.
    # It provides common functionality and configuration for all mailers.
    #
  RUBY
end

inject_into_file "app/models/application_record.rb", before: "class ApplicationRecord < ActiveRecord::Base" do
  <<~RUBY
    # The ApplicationRecord is the parent class for all models in the application.
    # It provides common functionality and configuration for all models.
    #
  RUBY
end

inject_into_file "config/application.rb", before: "class Application < Rails::Application" do
  <<~RUBY
    # The Application class is the main configuration class for the Rails application.
    # It contains settings and configurations that affect the entire application.
    #
  RUBY
end

run "rubocop -A"
