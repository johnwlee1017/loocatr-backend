class ImagesController < ApplicationController
  before_action :set_bathroom

  def index
    json_response(@bathroom.images)
  end

  def create
    @image = @bathroom.images.create!(image_params)
    json_response(@image, :created)
  end

  private
  def image_params
    params.permit(:image_url, :user_id)
  end

  def set_bathroom
    @bathroom = Bathroom.find(params[:bathroom_id])
  end
end
