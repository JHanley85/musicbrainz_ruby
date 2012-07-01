
require 'rubygems'
require 'spork'

Spork.prefork do

end

Spork.each_run do
	require 'factory_girl'
	require "#{File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))}/spec/factories"


end





