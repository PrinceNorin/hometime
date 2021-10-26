class Api::V1::ReservationsController < ApplicationController
  def create
    render json: ReservationService.new(params).save!
  end
end
