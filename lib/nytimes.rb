require "net/http"
require "json"
require "pry"
require "dotenv"

class NYTimes
  def initialize
    @data = top_stories_api_call
  end

  def top_stories_titles
    story_titles = []
    @data['results'].each do |story|
      story_titles << "#{story['title']} - #{story['section']}"
    end
    story_titles
  end

  def top_stories_api_call
    key = ENV["NYTIMESTOPSTORIES_API_KEY"]
    uri = URI("http://api.nytimes.com/svc/topstories/v1/technology.json?api-key=#{key}")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def events_api_call
    key = ENV["NYTIMESEVENTS_API_KEY"]
    uri = URI("http://api.nytimes.com/svc/topstories/v1/technology.json?api-key=#{key}")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def geo_api_call
    key = ENV["NYTIMESGEO_API_KEY"]
    uri = URI("http://api.nytimes.com/svc/topstories/v1/technology.json?api-key=#{key}")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
end
