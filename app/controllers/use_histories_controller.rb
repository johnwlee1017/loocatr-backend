class UseHistoriesController < ApplicationController
  before_action :set_bathroom

  def create
    @user_history = @bathroom.user_histories.create!(user_history_params)
    json_response(@user_history, :created)
  end

  def set_bathroom
    @bathroom = Bathroom.find(params[:bathroom_id])
  end

  private
  def user_history_params
    params.permit(:user_id)
  end
end
