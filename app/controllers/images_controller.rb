class ImagesController < ApplicationController
  before_action :set_bathroom

  def index
    json_response(@bathroom.images)
  end

  def set_bathroom
    @bathroom = Bathroom.find(params[:bathroom_id])
  end
end
