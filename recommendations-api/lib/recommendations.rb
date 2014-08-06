class Recommendations
  require 'net/http'
  require 'json'

  def all

    most_played_artist_data = most_played_lastfm_artist
    recommended_artist = most_similar_echonest_artist(most_played_artist_data[:name])

    "{\"results\":
       {\"recommendations\":[
         {
          \"artistName\": \"#{recommended_artist}\",
          \"sourceArtistName\": \"#{most_played_artist_data[:name]}\",
          \"listensCount\": \"#{most_played_artist_data[:playcount]}\"
         }
         ],
       },
     }"
  end

  def most_played_lastfm_artist
    uri = URI("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=aaronjrandall&api_key=954699d0c6199c3209bc3050b5fa631e&format=json")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    name = data['topartists']['artist'].first['name']
    playcount = data['topartists']['artist'].first['playcount']
    return {:name => name, :playcount => playcount}
  end

  def most_similar_echonest_artist(artist)
    puts "*** in echonest with #{artist}"
    uri = URI("http://developer.echonest.com/api/v4/artist/similar?api_key=YP3SF1D1HUU0YALC5&name=#{URI.escape(artist)}")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    data['response']['artists'].first['name']
  end
end
