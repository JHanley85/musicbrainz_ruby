module MusicBrainz
	class InstallGenerator < ::Rails::Generators::Base
		desc "Installs String Methods for Musicbrainz"

		def self.source_root
			File.expand_path("../templates", __FILE__)
		end

		def create_initializer
			template 'config/initializers/musicbrainz.rb.erb', 'config/initializers/musicbrainz.rb'
		end
	end

end