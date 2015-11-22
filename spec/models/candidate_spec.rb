require 'rails_helper'

RSpec.describe Candidate, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:bio) }
  it { is_expected.to belong_to :election }
end
