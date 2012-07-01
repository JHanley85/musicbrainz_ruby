module MusicBrainz
  class Query < Base
    attr_accessor :results
    attr_accessor :original_query
    attr_accessor :score
    attr_accessor :top_match
    attr_accessor :fetch

    def initialize(query, method, fetch)
      method=method[:entity]
      fetch=fetch[:fetch]
      @fetch=fetch if fetch.is_a?(Hash) && fetch.present? && fetch.has_key?(:fetch)
      @fetch=fetch if fetch.is_a?(Array) && fetch.present?
      @fetch=Array.new<<fetch  if fetch.is_a?(String) && fetch.present?
      available_methods=['artist', 'release', 'release-group', 'recording', 'work', 'label']
      method= available_methods.include?(method) ? method : nil
      if query.kind_of?(String)
        @query= query.is_mbid ? [:mbid, query] : query
      elsif query.kind_of?(Hash)
        @query=Hash.new
        query.each_pair do |k, v|
          @query[k]=v
        end
      else
        return false
      end
      #Now, transferring to query format.
      query_a=Array.new
      @query.each_pair do |k, v|
        if k==:date
          v=v.to_date
          v="#{v-7.days} TO #{v}"
        end
        query_a<<"#{k}:#{v}"
      end
      @original_query=query_a
      query_s=String.new
      query_s=URI.encode(query_a.join("AND"))
      #Dealing with non-mbid...
      get_query(method, query_s,fetch)
    end

    def inspect
      "#{@method}  ,#{@query} : #{@results}, #{@score}"
    end

    def get_query(method, query,fetch=[])
      puts method
      puts query
      puts fetch
      @request=self.class.get_query_path(method, query)
      #Find the highest score.
      @results=@request
      list="#{method}_list"
      case method
        when 'release'
          @results=@request['metadata'][list][method]
          @score=@results[0]['ext:score']
          if @score=='100'
            puts @results[0]['id']
            @top_match=MusicBrainz::Release.new(@results[0]['id'], fetch)

          end
        when 'artist'
          @results=@request['metadata'][list][method]
          @score=@results[0]['ext:score']
          if @score=='100'
            @top_match=MusicBrainz::Artist.new(@results['id'], fetch)
          end

        when 'release-group'
        when 'recording'
        when 'work'
        when 'label'


      end
    end
  end

end


