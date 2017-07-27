source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'react-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'rack-cors'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem "factory_girl_rails"
  gem 'ffaker'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#Api gems
gem 'active_model_serializers'

group :test do
  gem "rspec-rails", "~>  3.5"#, "~> 2.14"
  gem 'shoulda-matchers'#, '~> 3.1'
  gem 'email_spec'

end

gem "devise"
gem 'rake', '< 11.0'
gem 'kaminari'

gem 'dotenv-rails'

gem 'activeadmin', github: 'activeadmin'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
# gem 'cancan' # or cancancan
# gem 'draper', github: 'audionerd/draper', branch: 'rails5'
# gem 'pundit'
# gem 'activemodel-serializers-xml', git: 'https://github.com/rails/activemodel-serializers-xml'
# gem 'ransack'
# gem 'formtastic'

gem "paperclip", "~> 5.0.0.beta1"
gem 'aws-sdk', '~> 2'

gem "sidekiq"