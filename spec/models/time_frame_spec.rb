require 'rails_helper'

RSpec.describe TimeFrame, type: :model do
  it { should validate_presence_of(:closed) }
  it { should validate_presence_of(:open) }
  it { should belong_to(:bathroom) }
end
