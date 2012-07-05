require 'rubygems'
require 'spork'
require 'active_record'
require 'factory_girl'
require "#{File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))}/spec/factories"
require 'rails/all'
require 'capybara/cucumber'
require 'webrat'



Webrat.configure do |config|
	config.mode = :rake
end

Capybara.default_selector = :css


Spork.prefork do

end

Spork.each_run do



end





