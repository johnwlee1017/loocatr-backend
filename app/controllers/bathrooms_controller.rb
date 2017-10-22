class BathroomsController < ApplicationController
  before_action :set_bathroom, only: [:show, :update, :destroy]
  def index
    @closer_bathroom = Bathroom.all.select{ |bathroom| DistanceCalculator.distance(params[:lat], params[:lng], bathroom.latitude, bathroom.longitude) < 5 }[0..10]
    @opening_bathroom = @closer_bathroom.select { |bathroom| bathroom.opening }
    @sorted_bathroom = @opening_bathroom.sort_by{ |bathroom| DistanceCalculator.distance(params[:lat], params[:lng], bathroom.latitude, bathroom.longitude)}
    json_response(@sorted_bathroom)
  end

  def create
    @bathroom = Bathroom.create!(bathroom_params)
    json_response(@bathroom, :created)
  end

  def show
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
