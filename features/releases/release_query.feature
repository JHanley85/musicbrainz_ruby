@MB @release @query



Feature: Search for information on a release, using only an mbid.

  Scenario:
	Given I have loaded the model
	Given there are 0 releases
	And I save the following as "app/controllers/releases_controller.rb":
	"""
		class ReleasesController < ApplicationController
		  def index
			  @releases=Release.all
		  end
		  def show
		  end
		end
	"""
	And I save the following as "app/views/releases/index.html.erb":
	"""
	<ul><% @releases.each do |r| %><li><%= r.id %></li><li><%= r.mbid %></li><% end %></ul>
	"""
	And I save the following as "config/routes.rb"
	"""
	RailsApp::Application.routes.draw do
	resources :releases


	end
	"""
	When I start the rails application
	When I search for a "nonexistant" release with "mbid" of "a91c7de6-0530-4d23-897c-80c02341b328"
	Then A new release should be created with "mbid" of "a91c7de6-0530-4d23-897c-80c02341b328"
	And I should have 1 release
	And I go to the home page
	And I go to the releases page
	Then I should see "a91c7de6-0530-4d23-897c-80c02341b328"

    Scenario:
	  Given I query for a "release" on musicbrainz with "mbid" of "a91c7de6-0530-4d23-897c-80c02341b328"
	  When I save the following as "app/controllers/releases_controller":
	  """
	  class ReleasesController < ApplicationController
	  	def query
	  		query=@params
	  		@release=MusicBrainz::Release.new(query[:mbid],query[:fetch])
		end
	  end
      """
	  And I save the following as "app/views/releases/query.html.erb":
	  """
	  <ul>
	  	<%@release.recordings.each do |r|%>
	  	<li><%=r.recording['title']%></li>
	  	<%end%>
	  </ul>

	"""
	  And I save the following as "config/routes.rb"
	  """
	RailsApp::Application.routes.draw do
	resources :releases
	get 'releases/query'
	match "/releases"=>"releases#index"
	match '/releases/query/:query' =>'releases#query'

	end
	"""
	  When I start the rails application
      And I go to the release query page
	  Then I should see "The Day I Turned to Glass"