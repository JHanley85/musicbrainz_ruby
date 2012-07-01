module MusicBrainz
  class Release < Base

    attr_accessor :title
    attr_accessor :raw
    attr_accessor :artists
    attr_accessor :labels
    attr_accessor :recordings
    attr_accessor :release_groups
    @@class_name=self.name.gsub('MusicBrainz::', "").downcase

    def initialize(mbid, query=[])
      acceptable_subqueries=['artists', 'labels', 'recordings', 'release-groups']
      if query.kind_of?(Array)

        query.each do |query|
          unless acceptable_subqueries.include?(query)
            raise "#{query} is an unacceptable Sub-query for #{@@class_name.pluralize.upcase}. Please use one of the following:\n#{acceptable_subqueries}"
          end
        end
      else
        unless acceptable_subqueries.include?(query)
          raise "#{query} is an unacceptable Sub-query for #{@@class_name.pluralize.upcase}. Please use one of the following:\n#{acceptable_subqueries}"
        end
      end


      unless mbid.is_mbid
        raise "Unacceptable MBID for #{@@class_name.pluralize.upcase}. Check to make sure you have the correct mbid."
      end

      @mbid=mbid
      if query.present? && query!=[]
        @query=query.join("+") if query.kind_of?(Array)
        @query=query if query.kind_of?(String)
      else
        return false
      end
      @method='release'
      get_release(@method, @mbid, @query)
    end

    def get_release(method, mbid, query)
      @raw=self.class.get(method, mbid, query)

      subquery=query.split("+")
      if subquery.kind_of?(Array)
        subquery.each do |q|
          get_subquery(q)
        end
      else
        get_subquery(subquery)
      end

    end
    #TODO Move to Base class, and use it in each subclass. Expand for each usage as needed
    def get_subquery(subquery)
      subquery=subquery.gsub("-", "_")
      subquery_s=subquery.singularize
      if subquery_s=='artist'
        list_array=@raw['metadata']["#{@@class_name}"]["#{subquery_s}_credit"]['name_credit']["#{subquery_s}"]
      elsif subquery_s=='label'
        list_array=@raw['metadata']["#{@@class_name}"]["#{subquery_s}_info_list"]["#{subquery_s}_info"]["#{subquery_s}"]
      elsif subquery_s=='release_group'
        list_array=@raw['metadata']["#{@@class_name}"]["#{subquery_s}"]
      elsif subquery_s=='recording'
        list_array=@raw['metadata']["#{@@class_name}"]['medium_list']['medium']['track_list']['track']
      end
      if list_array.kind_of?(Array)
        sub=Array.new
        list_array.each do |r|
          sub<<OpenStruct.new(r)
        end
      else
        sub=OpenStruct.new(list_array)
      end

      @artists=sub if subquery=='artists'
      @labels=sub if subquery=='labels'
      @recordings=sub if subquery=='recordings'
      @release_groups=sub if subquery=='release_groups'
    end
    #TODO Expand the inspection, and add to base
    def inspect
      "#{@@class_name.upcase} identified by:#{@mbid}, Title:#{@title} }"
    end
  end
end