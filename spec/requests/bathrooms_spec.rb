require 'rails_helper'

RSpec.describe 'Bathrooms API', type: :request do
  let!(:bathrooms) { create_list(:bathroom, 10) }
  let(:bathroom_id) { Bathrooms.first.id }

  describe 'GET /bathrooms' do
    before { get '/bathrooms' }

    it 'returns bathrooms' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
