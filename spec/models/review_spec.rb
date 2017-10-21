require 'rails_helper'

RSpec.describe Review, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it { should validate_presence_of(:ratings) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:bathroom) }
  it { should belong_to(:user) }
end
