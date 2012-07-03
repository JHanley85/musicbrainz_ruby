@MB @setup
Feature: Installing MusicBrainz
  In order to install musicbrainz_ruby
  A user who generates the :install
  Files must be copied.

  Scenario: Installing Static Files
	Given I have a rails application
	And I run "rails generate music_brainz:install"
	Then the file "config/initializers/musicbrainz.rb" should exist


  Scenario:
	Given I have a rails application
	And I run "rails g scaffold release title:string release_date:date mbid:string type:string"
	And I setup the database
	And I turn off class caching in the rails application
	And I start the rails application
	When I go to the home page
    Then I should see "Welcome"
