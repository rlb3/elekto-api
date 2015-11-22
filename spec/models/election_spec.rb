require 'rails_helper'

RSpec.describe Election, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:start_at) }
  it { is_expected.to validate_presence_of(:end_at) }
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :candidates }
end
