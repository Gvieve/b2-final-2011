class Passenger < ApplicationRecord
  has_many :flight_passengers
  has_many :flights, through: :flight_passengers

  validates_presence_of :name, :age
  validates :age, numericality: { greater_than_or_equal_to: 0 }

  def self.age_18_and_over
    where("age >= 18")
  end
end
