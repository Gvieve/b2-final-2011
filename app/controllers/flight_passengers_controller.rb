class FlightPassengersController < ApplicationController
  def destroy
    # require "pry"; binding.pry
    flight_passenger = FlightPassenger.where(flight_id: params[:flight_id], passenger_id: params[:passenger_id])
    FlightPassenger.destroy(flight_passenger.first.id)

    redirect_to flight_path(params[:flight_id])
  end
end
