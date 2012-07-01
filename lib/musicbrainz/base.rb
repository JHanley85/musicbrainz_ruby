module MusicBrainz
  class Base

    def self.get(method, mbid, query)
      if method=='search'

        includes="?query=#{query}" unless query==[]
      else
        includes="?inc=#{query}" unless query==[]
      end
      path="/ws/2/#{method}/#{mbid}#{includes}"
      uri_host="musicbrainz.org"
      uri_port="80"
      http = Net::HTTP.new(uri_host, uri_port).get(path)
      response = http.response.code
      body = http.response.body

      body=Hash.from_xml(body)
      if response=="200"
        return body
      else
        return false
      end


    end

    def self.get_query_path(method, query)

      inc="?query=#{query}"
      path="/ws/2/#{method}#{inc}"
      uri_host="musicbrainz.org"
      uri_port="80"
      puts path
      http = Net::HTTP.new(uri_host, uri_port).get(path)
      response = http.response.code
      body = http.response.body

      body=Hash.from_xml(body)
      if response=="200"
        return body
      else
        return false
      end

    end

  end



end
