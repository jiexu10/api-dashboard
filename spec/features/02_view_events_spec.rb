# As a user
# I want to know what events are happening today
# So that I can plan my evening.

require "spec_helper"

feature "user sees current events on the home page", vcr: true do

  let(:geolocation) { Geolocation.new("127.0.0.1") }
  let(:events) { SeatGeek.new(geolocation.city) }
  scenario "user views the home page and see events" do
    visit("/")

    within ".events" do
      events.show_events.each do |event|
        expect(page).to have_content(event)
      end
    end
  end
end
