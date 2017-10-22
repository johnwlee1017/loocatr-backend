require 'rails_helper'

RSpec.describe TimeFrame, type: :model do
  it { should validate_presence_of(:close) }
  it { should validate_presence_of(:start) }
  it { should belong_to(:bathroom) }
end
