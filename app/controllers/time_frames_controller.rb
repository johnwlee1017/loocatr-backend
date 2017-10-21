class TimeFramesController < ApplicationController
  before_action :set_bathroom
  before_action :set_time_frame, only: [:update, :destroy]

  def create
    @time_frame = @bathroom.time_frames.create!(time_frame_params)
    json_response(@time_frame, :created)
  end

  def update
    @time_frame.update(time_frame_params)
    head :no_content
  end

  def destroy
    @time_frame.destroy
    head :no_content
  end

  private
  def time_frame_params
    params.permit(:day, :open, :closed)
  end

  def set_bathroom
    @bathroom = Bathroom.find_by(id: params[:bathroom_id])
  end

  def set_time_frame
    @time_frame = @bathroom.time_frames.find_by!(id: params[:id]) if @bathroom
  end
end
