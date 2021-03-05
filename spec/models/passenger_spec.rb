require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'relationships' do
    it {should have_many :flight_passengers}
    it {should have_many(:flights).through(:flight_passengers)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_numericality_of(:age).is_greater_than_or_equal_to(0)}
  end

  describe 'class methods' do
    describe 'age_18_and_over' do
      it 'returns all passengers with age greater than or equal to 18' do
        kim = Passenger.create!(name: "Kim Krause", age: 52)
        bob = Passenger.create!(name: "Bob Krause", age: 54)
        cody = Passenger.create!(name: "Cody Krause", age: 16)
        brad = Passenger.create!(name: "Brad Barajas", age: 18)
        eddie = Passenger.create!(name: "Eddie Anderson", age: 25)

        expect(Passenger.age_18_and_over.count).to eq(4)
        expect(Passenger.age_18_and_over.first.name).to eq("#{kim.name}")
        expect(Passenger.age_18_and_over.include?(cody)).to eq(false)
      end
    end
  end
end
