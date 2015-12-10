require "net/http"
require "json"
require "dotenv"
require "pry"

class WeatherUnderground
  attr_reader :data
  # temp
  def initialize(zip_code)
    @zip_code = zip_code
    @data = api_call
  end

  def weather_conditions
    conditions = @data['current_observation']['weather']
    temperature = @data['current_observation']['temperature_string']
    "#{conditions}, #{temperature}"
  end

  private
  def api_call
    key = ENV['WUNDERGROUND_API_KEY']
    uri = URI("http://api.wunderground.com/api/#{key}/conditions/q/#{@zip_code}.json")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
end
