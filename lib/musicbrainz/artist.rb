module MusicBrainz
  class Artist < Base
    attr_accessor :metadata
    attr_accessor :name
    attr_accessor :releases
    attr_accessor :artist_info
    attr_accessor :release_groups
    attr_accessor :works

    def initialize(mbid, query=[])
      #Valid sub-queries: artists, labels, recordings, release-groups
      @mbid=mbid.is_mbid ? mbid : false
      if query.present? && query!=[]
        @query=query.join("+")
      else
        @query='releases'
      end
      @method='artist'
      get_request(@method, @mbid, @query)
    end

    def get_request(method, mbid, query=[])
      @request=self.class.get(method, mbid, query)
      @metadata=@request['metadata']
      get_releases if query.include?('releases')
      get_info if query.include?('info')
      get_release_groups if query.include?('release-groups')
      get_works if query.include?('works')
    end

    def get_info
      @artist_info={:type => @metadata['artist']['type'], :mbid => @metadata['artist']['id']}
    end

    def get_releases
      releases=@metadata['artist']['release_list']['release']
      @releases=Array.new
      releases.each do |r|
        @releases<<OpenStruct.new(r)
      end
    end

    def get_release_groups
      release_groups=@metadata['artist']['release_group_list']['release_group']
      @release_groups=Array.new
      release_groups.each do |r|
        @release_groups<<OpenStruct.new(r)
      end
    end

    def get_works
      works=@metadata['artist']['work_list']['work']
      @works=Array.new
      works.each do |r|
        @works<<OpenStruct.new(r)
      end
    end
  end
end