class BathroomsController < ApplicationController
  before_action :set_bathroom, only: [:show, :update, :destroy]
  def index
    @closer_bathrooms = Bathroom.all.select{ |bathroom| DistanceCalculator.distance(params[:lat], params[:lng], bathroom.latitude, bathroom.longitude) < 5 }[0..10]
    @opening_bathrooms = @closer_bathrooms.select { |bathroom| bathroom.opening }
    @sorted_bathrooms = @opening_bathrooms.sort_by { |bathroom| DistanceCalculator.distance(params[:lat], params[:lng], bathroom.latitude, bathroom.longitude)}
    @sorted_bathrooms.map! { |bathroom| bathroom.average_ratings = Review.average_ratings(bathroom) }
    json_response(@sorted_bathrooms)
  end

  def create
    @bathroom = Bathroom.create!(bathroom_params)
    json_response(@bathroom, :created)
  end

  def show
    @bathroom.average_ratings = Review.average_ratings(@bathroom)
    json_response(@bathroom)
  end

  def update
    @bathroom.update(bathroom_params)
    head :no_content
  end

  def destroy
    @bathroom.destroy
    head :no_content
  end

  private
  def bathroom_params
    params.permit(:location_name, :latitude, :longitude, :over_21, :handicapped, :family, :customer_only)
  end
  def set_bathroom
    @bathroom = Bathroom.find(params[:id])
  end
end
