require 'rails_helper'

RSpec.describe "As a visitor when I visit the flight's show page" do
  before :each do
    @flt1 = Flight.create!(number: 1776, date: "04/05/2021", time: "11:00 am", departure_city: "Denver", arrival_city: "Chicago")
    @flt2 = Flight.create!(number: 145, date: "04/06/2021", time: "1:00 pm", departure_city: "Seattle", arrival_city: "Denver")
    @kim = @flt1.passengers.create!(name: "Kim Krause", age: 52)
    @bob = @flt1.passengers.create!(name: "Bob Krause", age: 54)
    @cody = @flt1.passengers.create!(name: "Cody Krause", age: 16)
    @brad = @flt1.passengers.create!(name: "Brad Barajas", age: 18)
    @eddie = Passenger.create!(name: "Eddie Anderson", age: 25)
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
    visit flight_path(@flt1)

    within ".passengers" do
      expect(page.all('li', count: 3))
      expect(page).to_not have_content("#{@cody.name}")

      within "#passenger-#{@kim.id}" do
        expect(page).to have_content("#{@kim.name}")
      end
      within "#passenger-#{@bob.id}" do
        expect(page).to have_content("#{@bob.name}")
      end
      within "#passenger-#{@brad.id}" do
        expect(page).to have_content("#{@brad.name}")
      end
    end
  end

  it "And I do not see the names of passengers that are not on this flight" do
    visit flight_path(@flt1)

    within ".passengers" do
      expect(page).to_not have_content("#{@eddie.name}")
    end
  end

  it "And I see the average age of all adult passengers on the flight" do
    visit flight_path(@flt1)

    expect(page).to have_content("Average age of adult passengers: #{@flt1.average_age_adult_passengers.round(2)}")
  end

  it "Next to each passengers name I see a button to remove that passenger from that flight" do
    visit flight_path(@flt1)

    within ".passengers" do
      expect(page.all('.button_to', count: 3))
    end
  end

  it "When I click on the 'Remove Passenger from Flight' button I return to the flight's show page and that passenger is not listed" do
    @flt1.passengers << @eddie
    visit flight_path(@flt1)

    within ".passengers" do
      expect(page).to have_content("#{@eddie.name}")

      within "#passenger-#{@eddie.id}" do
        expect(page).to have_button("Remove Passenger from Flight")
        click_button "Remove Passenger from Flight"
      end

      expect(current_path).to eq("/flights/#{@flt1.id}")
      expect(page).to_not have_content("#{@eddie.name}")
    end
  end

  it "When I remove a passenger from a single flight that passenger record is not deleted or removed from other flights" do
    @flt1.passengers << @eddie
    @flt2.passengers << @eddie

    visit flight_path(@flt1)

    within ".passengers" do
      within "#passenger-#{@eddie.id}" do
        click_button "Remove Passenger from Flight"
      end
      expect(current_path).to eq("/flights/#{@flt1.id}")
      expect(page).to_not have_content("#{@eddie.name}")
    end

    visit flight_path(@flt2)
     within ".passengers" do
       expect(page).to have_content("#{@eddie.name}")
     end
  end
end
