class UseHistoriesController < ApplicationController

  def create
    @use_history = UseHistory.create!(use_history_params)
    json_response(@use_history, :created)
  end

  private
  def use_history_params
    params.permit(:user_id, :bathroom_id)
  end
end
