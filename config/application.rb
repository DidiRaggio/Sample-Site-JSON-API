require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Whippering
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.view_specs false
      g.helper_specs false
      g.stylesheets = false
      g.javascripts = false
      g.helper = false
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.api_only = false
    config.middleware.use ActionDispatch::Flash
    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    
    config.middleware.insert_before 0, "Rack::Cors" do 
      allow do 
        origins 'http://localhost:3000'#DIDI CHANGE TO API 
        resource '*', :headers => :any, :methods => [:get, :post, :options] 
      end 
    end

    # ActionMailer::Base.smtp_settings = {
    #   :address => 'smtp.gmail.com',
    #   :domail => 'mail.google.com',
    #   :port => 587,
    #   :user_name => ENV['GMAIL_USERNAME'],
    #   :password => ENV['GMAIL_PASSWORD'],
    #   :authentication => "login",
    #   :enable_starttls_auto => true
    # }


  end
end
