# As a user
# I want to see the latest news headlines
# So that I can stay informed with current events.

require "spec_helper"

feature "user views news headlines", vcr: true do

  let(:news) { NYTimes.new }
  scenario "visit main page to see news" do
    visit("/")

    within ".news" do
      news.top_stories_titles.each do |story|
        if story.match(/&#8216;/)
          story.gsub!('&#8216;', '‘')
        end
        if story.match(/&#8217;/)
          story.gsub!('&#8217;', '’')
        end
        expect(page).to have_content(story)
      end
    end
  end
end
