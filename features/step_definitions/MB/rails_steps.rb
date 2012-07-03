Given /^I have a rails application$/ do

	step %{I ensure a rails application is generated}
	step %{the Gemfile is configured for testing}
	step %{the Gemfile contains this gem}
	step %{I run "bundle install"}
end
Given %r{^I ensure a rails application is generated$} do
	if File.exists?(Cukigem.app_root)
		step "I reset the rails application"
	else
		step "I generate a rails application"
	end
end
Given %r{^I reset the rails application$} do
	if File.exists?(Cukigem.app_root)
		Dir.chdir(Cukigem.app_root) do
			Cukigem.paths_to_clear.map {|f| Dir[f] }.flatten.each do |dir|
				FileUtils.rm_rf(dir) if File.exists?(dir)
			end

			step "I reset the routes file"
			step "I define an application controller"
			step "I reset the Gemfile"
		end
	end
end
Given %r{^I generate a rails application$} do

	Dir.chdir(Cukigem.temp_root) do
		`rails new "#{Cukigem.application_name}"`
	end

	step "I turn off class caching in the rails application"
end
Given %r{^I turn off class caching in the rails application} do
	Dir.chdir(Cukigem.app_root) do
		File.open("config/environments/test.rb", "r+") do |f|
			f.write f.read.gsub!(/config.cache_classes.*$/, "config.cache_classes = false")
		end
	end
end

Given %r{^I reset the routes file$} do
	step %{I save the following as "config/routes.rb"}, %{RailsApp::Application.routes.draw do\n resources :models\nend}
end

When %r{^I save the following as "([^"]*)"} do |path, string|
	FileUtils.mkdir_p(File.join(Cukigem.app_root, File.dirname(path)))
	File.open(File.join(Cukigem.app_root, path), "w") do |file|
		file.write(string)

	end
	File.open(File.join(Cukigem.app_root, path), "rb") do |file|
	puts	file.read

	end

end


Given %r{^I define an application controller$} do
	step %{I save the following as "app/controllers/application_controller.rb"}, %{class ApplicationController < ActionController::Base\nend}
end

Given %r{^I reset the Gemfile$} do
	step %{I save the following as "Gemfile"}, %{
    source 'https://rubygems.org'
			gem 'rails', '3.2.6'
			gem 'sqlite3'
			group :assets do
			  gem 'sass-rails',   '~> 3.2.3'
			  gem 'coffee-rails', '~> 3.2.1'
			  gem 'therubyracer', :platforms => :ruby
			  gem 'uglifier', '>= 1.0.3'
			end
			gem 'jquery-rails'
  }
end
When %r{^the Gemfile is configured for testing$} do
	step %{I append the following to "Gemfile"}, %{
    group :test do
			gem "guard-rspec"
		  gem "factory_girl_rails", ">= 1.6.0"
		  gem "cucumber-rails", ">= 1.2.1"
		  gem "capybara", ">= 1.1.2"
		  gem "database_cleaner"
		  gem "launchy"
		end
  }
end
When %r{^I append the following to "([^"]*)"} do |path, string|
	FileUtils.mkdir_p(File.join(Cukigem.app_root, File.dirname(path)))
	File.open(File.join(Cukigem.app_root, path), "a+") do |file|
		file.write(string)
	end
end
When %r{^the Gemfile contains this gem$} do
	step %{I append the following to "Gemfile"}, %{gem "musicbrainz_ruby","0.1.3"}
end
When %r{^I run "([^"]*)"$} do |command|
	Dir.chdir(Cukigem.app_root) do
		`#{command}`
	end
end

Then %r{^the file "([^"]*)" should exist$} do |file|
	File.should be_exist(File.join(Cukigem.app_root, file))
end
When %r{^I setup the database$} do
	step %{I run "rake db:create db:migrate --trace RAILS_ENV=test"}
end
When %r{^I start the rails application$} do
	Dir.chdir(Cukigem.project_root)
	Dir.chdir(Cukigem.app_root) do
		ENV["RAILS_ENV"] = "test"
		require "#{Cukigem.app_root}/config/environment.rb"

		if Object.const_defined?(:Capybara)
			require "capybara/rails"
		elsif Object.const_defined?(:Webrat)
			require "webrat/rails"
		end

		ActiveRecord::Base.clear_all_connections!
	end
end

When %r{^I start the rails application at "([^"]*)"$} do |path|
	Dir.chdir(Cukigem.project_root)
	Dir.chdir(path) do
		ENV["RAILS_ENV"] = "test"
		require "config/environment.rb"

		if Object.const_defined?(:Capybara)
			require "capybara/rails"
		elsif Object.const_defined?(:Webrat)
			require "webrat/rails"
		end
	end
end
When %r{^I add (.+) to routes.rb$} do |string|

	FileUtils.mkdir_p(File.join(Cukigem.app_root, File.dirname(path)))
	File.open(File.join(Cukigem.app_root, "config/routes.rb"), "w") do |file|
		file.write(string)
	end

end


