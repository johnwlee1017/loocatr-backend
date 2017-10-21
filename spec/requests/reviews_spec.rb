require 'rails_helper'

RSpec.describe 'Reviews API' do
  let!(:bathroom) { create(:bathroom) }
  let!(:user) { create(:user) }
  let!(:reviews) { create_list(:review, 20, bathroom_id: bathroom.id) }
  let(:bathroom_id) { bathroom.id }
  let(:id) { reviews.first.id }

  describe 'POST /bathrooms/:bathroom_id/reviews' do
    let(:valid_attributes) { { ratings: 5, description: "aaa", user_id: user.id } }

    context 'when request attributes are valid' do
      before { post "/bathrooms/#{bathroom_id}/reviews", params: valid_attributes }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/bathrooms/#{bathroom_id}/reviews", params: {} }

      it 'retruns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: /)
      end
    end
  end

  describe 'PATCH /bathrooms/:bathroom_id/reviews/:id' do
    let(:valid_attributes) { { open: 2340 } }
    before { patch "/bathrooms/#{bathroom_id}/reviews/#{id}", params: valid_attributes }

    context 'when review exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the time frame' do
        updated_review = Review.find(id)
        expect(updated_review.open).to eq 2340
      end
    end

    context 'when the time frame does not exist' do
      let(:id) { 0 }
      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Review/)
      end
    end
  end

  describe 'DELETE /bathrooms/:bathroom_id/reviews/:id' do
    before { delete "/bathrooms/#{bathroom_id}/reviews/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
