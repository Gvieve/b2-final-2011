class Flight < ApplicationRecord
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  validates_presence_of :number, :date, :time, :departure_city, :arrival_city

  def self.ordered_by_departure_city
    order(:departure_city, :arrival_city)
  end

  def adult_passengers
    passengers.age_18_and_over
  end

  def average_age_adult_passengers
    # begin
      adult_passengers.average(:age)
    # rescue
    #   'no passengers on this flight yet'
  end
end
