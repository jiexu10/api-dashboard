require "net/http"
require "json"
require "pry"
require "dotenv"

class OnConnect
  def initialize(zip_code, date = Date.today)
    @zip_code = zip_code
    @date = date
    @data = api_call(@zip_code, @date)
  end

  def showtimes
    all_movies = []
    @data.each do |movie|
      movie_info = movie['title']
      movie['showtimes'].each do |showtime|
        show_info = "#{movie_info} @ #{showtime['theatre']['name']} "
        time_string = Time.parse(showtime['dateTime']).to_s
        time_parse = time_string.match(/(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})/)
        show_info += "#{time_parse}"
        all_movies << show_info
      end
    end
    all_movies
  end

  private
  def api_call(zip_code, date)
    key = ENV['ONCONNECT_API_KEY']
    uri = URI("http://data.tmsapi.com/v1.1/movies/showings?startDate=#{date}&zip=#{zip_code}&api_key=#{key}")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
end
