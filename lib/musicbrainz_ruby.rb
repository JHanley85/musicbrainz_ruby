require "net/http"
require "uri"
require 'json'
require 'ostruct'

$: << File.dirname(__FILE__)

module MusicBrainz

end
require 'musicbrainz/base.rb'
require 'musicbrainz/artist.rb'
require 'musicbrainz/label.rb'
require 'musicbrainz/recording.rb'
require 'musicbrainz/release.rb'
require 'musicbrainz/release_group.rb'

require 'musicbrainz/work.rb'
require 'musicbrainz/query.rb'
require 'generators/musicbrainz_ruby'