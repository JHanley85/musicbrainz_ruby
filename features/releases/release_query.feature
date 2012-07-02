@MB @release @query



Feature: Search for information on a release, using only an mbid.

  Scenario:
	Given I have loaded the model
	Given there are 0 releases
	And I save the following as "app/controllers/releases_controller.rb":
	"""
		class ReleasesController<ApplicationController
		  def index
			  @releases=Releases.all
		  end
		end
	"""
	And I save the following as "app/views/releases/index.html.erb":
	"""
	  	<%@releases.each do |r|%>
	  	<%=r.id>
	  	<%=r.mbid%>
	  	<%end%>
	"""
	And I save the following as "config/routes.rb"
	"""
	RailsApp::Application.routes.draw do
	resources :releases
	match "/releases"=>"releases#index"

	end
	"""
	When I search for a "nonexistant" release with "mbid" of "64814a3d-f11a-3ad7-9f23-41c68279e0be"
	Then A new release should be created with "mbid" of "64814a3d-f11a-3ad7-9f23-41c68279e0be"
	And I should have 1 release
	When I go to the releases page


