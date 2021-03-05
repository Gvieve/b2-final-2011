require 'rails_helper'

RSpec.describe "As a visitor when I visit the flights index page" do
  before :each do
    @flt1 = Flight.create!(number: 1776, date: "04/05/2021", time: "11:00 am", departure_city: "Denver", arrival_city: "Chicago")
    @flt2 = Flight.create!(number: 145, date: "04/06/2021", time: "1:00 pm", departure_city: "Seattle", arrival_city: "Denver")
    @flt3 = Flight.create!(number: 1879, date: "04/05/2021", time: "5:00 pm", departure_city: "Denver", arrival_city: "San Francisco")
    @flt4 = Flight.create!(number: 9813, date: "04/03/2021", time: "6:00 am", departure_city: "Boston", arrival_city: "Los Angeles")
  end

  it "I see each flight in the system including its number, departure city, and arrival city" do
    visit flights_path

    expect(page.all('li', count: 4))

    within "#flight-#{@flt1.id}" do
      expect(page).to have_content("Flight num. #{@flt1.number} departing from: #{@flt1.departure_city} arriving: #{@flt1.arrival_city}")
      expect(page).to_not have_content("Flight num. #{@flt2.number}")
    end
    within "#flight-#{@flt2.id}" do
      expect(page).to have_content("Flight num. #{@flt2.number} departing from: #{@flt2.departure_city} arriving: #{@flt2.arrival_city}")
    end
    within "#flight-#{@flt3.id}" do
      expect(page).to have_content("Flight num. #{@flt3.number} departing from: #{@flt3.departure_city} arriving: #{@flt3.arrival_city}")
    end
    within "#flight-#{@flt4.id}" do
      expect(page).to have_content("Flight num. #{@flt4.number} departing from: #{@flt4.departure_city} arriving: #{@flt4.arrival_city}")
    end
  end

  it "And I see that flights are listed in alphabetical order by departure city (A - Z) and then arrival_city" do
    visit flights_path

    expect(@flt4.departure_city).to appear_before(@flt1.departure_city)
    expect(@flt1.arrival_city).to appear_before(@flt3.arrival_city)
    expect(@flt3.departure_city).to appear_before(@flt2.departure_city)
  end
end
