require "./lib/geolocation"
require "./lib/weatherunderground"
require "./lib/nytimes"
require "./lib/seatgeek"
require "./lib/onconnect"
require "sinatra/base"

require "dotenv"
Dotenv.load

class Dashboard < Sinatra::Base
  get("/") do
    @ip = request.ip
    @geolocation = Geolocation.new(@ip)

    @weather = WeatherUnderground.new(@geolocation.zip)
    @top_stories = NYTimes.new
    @events = SeatGeek.new(@geolocation.city)
    @movies = OnConnect.new(@geolocation.zip)

    erb :dashboard
  end
end
