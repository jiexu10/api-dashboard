require "net/http"
require "json"
require "dotenv"
require "pry"

class SeatGeek
  def initialize(city)
    @city = city
    @data = api_call
  end

  def show_events
    output = []
    @data['events'].each do |event|
      output << "#{event["title"]} @ #{event['venue']['name']}"
    end
    output
  end

  private
  def api_call
    uri_string ="http://api.seatgeek.com/2/events?venue.city=#{@city}"
    uri = URI(uri_string)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
