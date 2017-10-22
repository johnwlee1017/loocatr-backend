class BathroomsController < ApplicationController
  before_action :set_bathroom, only: [:show, :update, :destroy]
  def index
    @closest_available_bathrooms = Bathroom.fetch_bathrooms(params[:lat], params[:lng])
    json_response(@closest_available_bathrooms)
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
