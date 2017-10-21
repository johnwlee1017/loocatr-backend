class BathroomsController < ApplicationController
  before_action :set_bathroom, only: [:show, :update, :destroy]
  def index
    @bathrooms = Bathroom.all
    json_response(@bathrooms)
  end

  def create
    @bathroom = Bathroom.create!(bathroom_params)
    json_response(@bathroom, :created)
  end

  def show
    json_response(@bathroom)
  end

  private
  def bathroom_params
    params.permit(:location_name, :latitude, :longitude, :over_21, :handicapped, :family, :customer_only)
  end
  def set_bathroom
    @bathroom = Bathroom.find(params[:id])
  end
end
