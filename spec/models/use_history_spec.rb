require 'rails_helper'

RSpec.describe UseHistory, type: :model do
    it { should belong_to(:bathroom) }
end
