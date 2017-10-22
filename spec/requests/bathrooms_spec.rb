require 'rails_helper'

RSpec.describe 'Bathrooms API', type: :request do
  let!(:bathrooms) { create_list(:bathroom, 2) }
  let!(:time_frames1) {
    7.times { |i| create_list(:time_frame, 1, day: i, start: '0001', close: '2358', bathroom_id: bathrooms.first.id)}
  }
  let!(:time_frames2) {
    7.times { |i| create_list(:time_frame, 1, day: i, start: '0100', close: '1111', bathroom_id: bathrooms.last.id)}
  }
  let(:bathroom_id) { bathrooms.first.id }

  describe 'GET /bathrooms' do
    before { get '/bathrooms' }

    it 'returns currently opend bathrooms' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /bathrooms/:id' do
    before { get "/bathrooms/#{bathroom_id}"}

    context 'when the record exists' do
      it 'returns the bathroom' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(bathroom_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:bathroom_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bathroom/)
      end
    end
  end

  describe 'POST /bathrooms' do
    let(:valid_attributes) {{ location_name: 'Library',
                              latitude: 60,
                              longitude: 50,
                              over_21: true,
                              handicapped: true,
                              family: true,
                              customer_only: true
                           }}
    context 'when the request is valid' do
      before { post '/bathrooms', params: valid_attributes }

      it 'creates a bathroom' do
        expect(json['location_name']).to eq('Library')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/bathrooms', params: { location_name: 'Library' }}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: /)
      end
    end
  end

  describe 'PATCH /bathrooms/:id' do
    let(:valid_attributes) { { handicapped: false } }

    context 'when the record exists' do
      before { patch "/bathrooms/#{bathroom_id}" }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /bathrooms/:id' do
    before { delete "/bathrooms/#{bathroom_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
