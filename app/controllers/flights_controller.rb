class FlightsController < ApplicationController
  def index
    @flights = Flight.ordered_by_departure_city
  end
end
