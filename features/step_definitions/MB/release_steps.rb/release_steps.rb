Given /^I have loaded the model$/ do
	models="#{Cukigem.app_root}/app/models/release.rb"
	require models
	puts models
end
When /^I search for a "(.+)" (.+) with "(.+)" of "(.*?)"$/ do |existing,model_str,attr,value|
	model_str = model_str.gsub(/\s/, '_').singularize
	klass = eval(model_str.camelize)
	if existing=="nonexistant"
			@release=klass.where(attr=>value)

	end
end
Given /^The query does not match a (.+)$/ do |model|
	@release.count.should==nil
end
Then /^A new (.+) should be created with "(.*?)" of "(.*?)"$/ do |model_str,attr,value|
	model_str = model_str.gsub(/\s/, '_').singularize

	klass = eval(model_str.camelize)
	@new_release=klass.create!(attr=>value)
end
Then /^I should have (\d+) (.+)$/ do |n, model_str|
	model_str = model_str.gsub(/\s/, '_').singularize

	klass = eval(model_str.camelize)
	klass.count.should==n.to_i

		end

Given /^there are (\d+) (.+)$/ do |n, model_str|
	model_str = model_str.gsub(/\s/, '_').singularize
	model_sym = model_str.to_sym
	klass = eval(model_str.camelize)
	klass.transaction do
		klass.destroy_all
		n.to_i.times do |i|
			Factory(model_sym)
		end
	end
end
