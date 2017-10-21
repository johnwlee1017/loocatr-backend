require 'rails_helper'

RSpec.describe Bathroom, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should have_many(:time_frames).dependent(:destroy) }
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:images).dependent(:destroy) }

end
