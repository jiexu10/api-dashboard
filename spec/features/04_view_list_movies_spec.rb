# As a user
# I want to see a list of movies playing near me
# So that I can decide if I want to see a movie today.

require "spec_helper"

feature "user views list of movies playing nearby", vcr: true do

  let(:geolocation) { Geolocation.new("127.0.0.1") }
  let(:movies) { OnConnect.new(geolocation.zip) }
  scenario "user visits main page and sees list of movies" do
    visit("/")

    within ".movies" do
      movies.showtimes.each do |movie|
        expect(page).to have_content(movie)
      end
    end
  end
end
