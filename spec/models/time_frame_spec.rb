require 'rails_helper'

RSpec.describe TimeFrame, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it { should validate_presence_of(:closed) }
  it { should validate_presence_of(:open) }
  it { should belong_to(:bathroom) }
  it { should have_many(:items).dependent(:destroy) }
end
