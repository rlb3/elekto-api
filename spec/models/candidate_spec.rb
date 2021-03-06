require 'rails_helper'

RSpec.describe Candidate, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:bio) }
  it { is_expected.to belong_to :election }
  it { is_expected.to have_attached_file(:image) }
  it { is_expected.to validate_attachment_content_type(:image).
                       allowing('image/png', 'image/gif').
                       rejecting('text/plain', 'text/xml')
  }
end
