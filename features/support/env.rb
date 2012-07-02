require 'rubygems'
require 'spork'
require 'active_record'
require 'factory_girl'
require "#{File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))}/spec/factories"
require 'rails/all'
require 'capybara/cucumber'
require 'webrat'
require "webrat"

Webrat.configure do |config|
	config.mode = :rails
end

begin
	require 'database_cleaner'
	require 'database_cleaner/cucumber'
	DatabaseCleaner.strategy = :truncation
	Capybara.default_selector = :css
rescue NameError
	raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end


Spork.prefork do

end

Spork.each_run do



end





