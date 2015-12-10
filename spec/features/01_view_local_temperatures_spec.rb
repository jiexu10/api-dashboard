# As a user
# I want to see the local temperature
# So that I can dress accordingly.

require "spec_helper"

feature "user sees the local weather", vcr: true do

  let(:geolocation) { Geolocation.new("127.0.0.1") }
  let(:weather) { WeatherUnderground.new(geolocation.zip) }
  scenario "user visits main page to see weather" do
    visit "/"

    within ".location" do
      expect(page).to have_content(geolocation.city)
      expect(page).to have_content(geolocation.state)
      expect(page).to have_content(geolocation.country)
    end

    within ".weather" do
      expect(page).to have_content(weather.weather_conditions)
    end
  end
end
