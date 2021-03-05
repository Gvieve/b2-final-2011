require 'rails_helper'

RSpec.describe "As a visitor when I visit the flight's show page" do
  before :each do
    @flt1 = Flight.create!(number: 1776, date: "04/05/2021", time: "11:00 am", departure_city: "Denver", arrival_city: "Chicago")
    @flt2 = Flight.create!(number: 145, date: "04/06/2021", time: "1:00 pm", departure_city: "Seattle", arrival_city: "Denver")
    # @flt3 = Flight.create!(number: 1879, date: "04/05/2021", time: "5:00 pm", departure_city: "Denver", arrival_city: "San Francisco")
    # @flt4 = Flight.create!(number: 9813, date: "04/03/2021", time: "6:00 am", departure_city: "Boston", arrival_city: "Los Angeles")
    kim = @flt1.passengers.create!(name: "Kim Krause", age: 52)
    bob = @flt1.passengers.create!(name: "Bob Krause", age: 54)
    cody = @flt1.passengers.create!(name: "Cody Krause", age: 16)
    brad = @flt1.passengers.create!(name: "Brad Barajas", age: 18)
    eddie = @flt2.passengers.create!(name: "Eddie Anderson", age: 25)
  end

  it "Then I see the flight's number, date, time, departure city, and arrival city" do
    visit flight_path(@flt1)

    expect(page).to have_content("Flight num.: #{@flt1.number}")
    expect(page).to_not have_content("#{@flt2.number}")
    expect(page).to have_content("Date: #{@flt1.date}")
    expect(page).to have_content("Time: #{@flt1.time}")
    expect(page).to have_content("Departing from: #{@flt1.departure_city}")
    expect(page).to have_content("Arriving at: #{@flt1.arrival_city}")
  end

  it "And I see the names of all adult passengers on the flight" do

  end

  it "And I see the average age of all adult passengers on the flight" do

  end
end
