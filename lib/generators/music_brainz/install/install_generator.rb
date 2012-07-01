module MusicBrainz
	class InstallGenerator < ::Rails::Generators::Base
		desc "Installs String Methods for Musicbrainz"
		path= File.expand_path("../templates", __FILE__)

		create_file 'config/initializers/musicbrainz.rb', File.read("#{path}/config/initializers/musicbrainz_ruby.rb")

	end

	end