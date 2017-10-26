class UsersController < ApplicationController

  def index
    user_id = params[:user_id]
    @bathrooms = Bathroom.where(user_id: user_id)
    @reviews = Review.where(user_id: user_id)
    @histories = UseHistory.where(user_id: user_id).map { |history| history.bathroom }
    json_response({bathrooms: @bathrooms, reviews: @reviews, histories: @histories})
  end
end
