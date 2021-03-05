require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it {should have_many :flight_passengers}
    it {should have_many(:passengers).through(:flight_passengers)}
  end

  describe 'validations' do
    it {should validate_presence_of :number}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
    it {should validate_presence_of :departure_city}
    it {should validate_presence_of :arrival_city}
  end

  describe 'class methods' do
    describe 'ordered_by_departure_city' do
      it 'returns flights ordered by departure city then arrival_city' do
        flt1 = Flight.create!(number: 1776, date: "04/05/2021", time: "11:00 am", departure_city: "Denver", arrival_city: "Chicago")
        flt2 = Flight.create!(number: 145, date: "04/06/2021", time: "1:00 pm", departure_city: "Seattle", arrival_city: "Denver")
        flt3 = Flight.create!(number: 1879, date: "04/05/2021", time: "5:00 pm", departure_city: "Denver", arrival_city: "San Francisco")
        flt4 = Flight.create!(number: 9813, date: "04/03/2021", time: "6:00 am", departure_city: "Boston", arrival_city: "Los Angeles")

        expect(Flight.ordered_by_departure_city.first.departure_city).to eq(flt4.departure_city)
        expect(Flight.ordered_by_departure_city.second.departure_city).to eq(flt1.departure_city)
        expect(Flight.ordered_by_departure_city.second.arrival_city).to eq(flt1.arrival_city)
        expect(Flight.ordered_by_departure_city.third.departure_city).to eq(flt3.departure_city)
        expect(Flight.ordered_by_departure_city.last.departure_city).to eq(flt2.departure_city)
      end
    end
  end

  describe 'instance methods' do
    describe 'adult_passengers' do
      it 'returns passengers for a flight that are 18 or over' do
        flt1 = Flight.create!(number: 1776, date: "04/05/2021", time: "11:00 am", departure_city: "Denver", arrival_city: "Chicago")
        flt2 = Flight.create!(number: 145, date: "04/06/2021", time: "1:00 pm", departure_city: "Seattle", arrival_city: "Denver")
        kim = flt1.passengers.create!(name: "Kim Krause", age: 52)
        bob = flt1.passengers.create!(name: "Bob Krause", age: 54)
        cody = flt1.passengers.create!(name: "Cody Krause", age: 16)
        brad = flt1.passengers.create!(name: "Brad Barajas", age: 18)
        eddie = flt2.passengers.create!(name: "Eddie Anderson", age: 25)

        expect(flt1.adult_passengers.count).to eq(3)
        expect(flt1.adult_passengers.first.name).to eq("#{kim.name}")
        expect(flt1.adult_passengers.second.name).to eq("#{bob.name}")
        expect(flt1.adult_passengers.last.name).to eq("#{brad.name}")
        expect(flt1.adult_passengers.include?(cody)).to eq(false)
        expect(flt1.adult_passengers.include?(eddie)).to eq(false)
      end
    end
  end
end
