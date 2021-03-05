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
end
