class BathroomsController < ApplicationController
  def index
    @bathrooms = Bathroom.all
    json_response(@bathrooms)
  end
end
