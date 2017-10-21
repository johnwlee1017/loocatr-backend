require 'rails_helper'

RSpec.describe 'TimeFrames API' do
  let!(:bathroom) { create(:bathroom) }
  let!(:time_frames) { create_list(:time_frame, 20, bathroom_id: bathroom.id) }
  let(:bathroom_id) { bathroom.id }
  let(:id) { time_frames.first.id }

  describe 'GET /bathrooms/:bathroom_id/time_frames' do
    before { get "/bathrooms/#{bathroom_id}/time_frames" }

    context 'when bathrooms exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all time_frames' do
        expect(json.size).to eq(20)
      end
    end

    context 'when bathroom does not exist' do
      let(:bathroom_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find /)
      end
    end
  end

  describe 'POST /bathrooms/:bathroom_id/time_frames' do
    let(:valid_attributes) { { day: 0, open: "2120", closed: "2309", is_overnight: true } }

    context 'when request attributes are valid' do
      before { post "/bathrooms/#{bathroom_id}/time_frames", params: valid_attributes }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/bathrooms/#{bathroom_id}/time_frames", params: {} }

      it 'retruns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: /)
      end
    end
  end

  describe 'PATCH /bathrooms/:bathroom_id/time_frames/:id' do
    let(:valid_attributes) { { open: 2340 } }
    before { patch "/bathrooms/#{bathroom_id}/time_frames/#{id}", params: valid_attributes }

    context 'when time_frame exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the time frame' do
        updated_time_frame = TimeFrame.find(id)
        expect(updated_time_frame.open).to eq 2340
      end
    end

    context 'when the time frame does not exist' do
      let(:id) { 0 }
      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find TimeFrame/)
      end
    end
  end

  describe 'DELETE /bathrooms/:bathroom_id/time_frames/:id' do
    before { delete "/bathrooms/#{bathroom_id}/time_frames/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
