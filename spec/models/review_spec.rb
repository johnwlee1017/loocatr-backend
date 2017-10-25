require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should validate_presence_of(:ratings) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:bathroom) }
end
