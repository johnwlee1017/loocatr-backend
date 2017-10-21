class ReviewsController < ApplicationController
  before_action :set_bathroom
  before_action :set_review, only: [:update, :destroy]

  def index
    json_response(@bathroom.reviews)
  end

  def create
    @bathroom.reviews.create!(review_params)
    json_response(@review, :created)
  end

  def update
    @review.update(review_params)
    head :no_content
  end

  def destroy
    @review.destroy
    head :no_content
  end

  private
  def review_params
    params.permit(:ratings, :description, :user_id)
  end

  def set_bathroom
    @bathroom = Bathroom.find(params[:bathroom_id])
  end

  def set_review
    @review = @bathroom.reviews.find_by!(id: params[:id]) if @bathroom
  end
end
