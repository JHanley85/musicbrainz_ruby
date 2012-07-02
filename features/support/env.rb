require 'rubygems'
require 'spork'
require 'active_record'
require 'factory_girl'
require "#{File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))}/spec/factories"
require 'rails/all'

begin
	require 'database_cleaner'
	require 'database_cleaner/cucumber'
	DatabaseCleaner.strategy = :truncation

rescue NameError
	raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end


Spork.prefork do

end

Spork.each_run do



end





