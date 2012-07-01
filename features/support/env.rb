
require 'rubygems'
require 'spork'

Spork.prefork do

end

Spork.each_run do
	Before do
		require 'factory_girl'
		Dir.glob(File.join(File.dirname(__FILE__), '../../spec/factories/*.rb')).each {|f| require f }
		Factory.factories.keys.each {|factory| Factory(factory) }
	end

	#Capybara.default_selector = :css
	require 'cucumber/rails'
	Cucumber::Rails::Database.javascript_strategy = :truncation
	ActionController::Base.allow_rescue = false
	# This code will be run each time you run your specs.
	begin
		DatabaseCleaner.strategy = :transaction
	rescue NameError
		raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
	end
end





