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
run "rubocop -A"

