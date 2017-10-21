require 'rails_helper'

RSpec.describe Image, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it { should validate_presence_of(:image_url) }
  it { should belong_to(:bathroom) }
end
