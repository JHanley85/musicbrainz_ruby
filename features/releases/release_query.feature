@MB @release @query
Feature: Search for information on a release, using only an mbid.


  Scenario:
	Given there are 0 models
	And I save the following as "app/controllers/releases_controller.rb":
	"""
		ReleasesController<ApplicationController
		def index
			@releases=Releases.all
		end
	"""
	When I search for a nonexistant release with mbid of "64814a3d-f11a-3ad7-9f23-41c68279e0be"
	Given The query does not match a release
	Then A new release should be created
	And I should have 1 release


