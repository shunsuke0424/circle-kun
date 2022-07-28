class PlacesController < ApplicationController
  def index
    render json: { places: Place.to_options }
  end
end