class BathroomsController < ApplicationController
  before_action :set_bathroom, only: [:show, :update, :destroy]
  def index
    @bathrooms = Bathroom.all
    json_response(@bathrooms)
  end

  def show
    json_response(@bathroom)
  end

  private
  def set_bathroom
    @bathroom = Bathroom.find(params[:id])
  end
end
