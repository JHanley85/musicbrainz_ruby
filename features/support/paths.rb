module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
	      '/'
    when /the release query page/
	    params=Array.new
	    @params.each do |k,v|
		  params<<"#{k}=#{v}"
	    end
	    params_string=params.join('&')
      "/releases/query?#{params_string}"
    when "the releases page"
		  "/releases/"

	    # Add more page name => path mappings here
	    else
		    if path = match_rails_path_for(page_name)
			    path
		    else
			    raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
					          "Now, go and add a mapping in features/support/paths.rb"
		    end
    end
  end

  def match_rails_path_for(page_name)
	  if page_name.match(/the (.*) page/)
		  return send "#{$1.gsub(" ", "_")}_path" rescue nil
	  end
  end
end

World(NavigationHelpers)