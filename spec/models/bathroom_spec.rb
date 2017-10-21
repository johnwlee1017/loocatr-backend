require 'rails_helper'

RSpec.describe Bathroom, type: :model do
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should have_many(:time_frames).dependent(:destroy) }
  it { should have_many(:reviews) }
  it { should have_many(:images).dependent(:destroy) }

end
