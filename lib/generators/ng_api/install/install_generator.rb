require 'rails/generators'

module NgApi
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    attr_reader :app_name

    def install
      unless defined?(Grape)
        say "adding grape gem to your gemfile"
        append_file "Gemfile", "\n", :force => true
        gem 'grape', :git => 'https://github.com/intridea/grape.git'
        gem "grape-rabl"
      else
        say "Found it!"
      end

      empty_directory "app/api"
      empty_directory "app/views/api"

      application = File.open(Rails.root.join("config/application.rb")).try :read

      unless application.index("config.autoload_paths += %W(\#\{config.root\}/app/api)")
        append_file "config/application.rb", "\n", :force => true
        application "config.autoload_paths += %W(\#\{config.root\}/app/api)"
      else
        say "Found it!"
      end

      unless application.index("env['api.tilt.root']")
        append_file "config/application.rb", "\n", :force => true
        application "config.middleware.use(Rack::Config){|env| env['api.tilt.root'] = Rails.root.join('app', 'views', 'api')}"
        say "added setting to your application.rb"
      else
        say "Found it!"
      end

      @app_name = Rails.application.class.to_s.split("::").first
      template "api.rb.erb", "app/api/api.rb"
      copy_file "helpers.rb", "app/api/helpers.rb"
      copy_file "demo.rabl", "app/views/api/demo.rabl"

      append_file "config/routes.rb", "\n", :force => true
      api_url = "mount #{@app_name}::API => '/'"
      route api_url
      route "require 'api'"

      say "all is ok"
    end
  end 
end
