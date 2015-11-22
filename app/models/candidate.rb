class Candidate < ActiveRecord::Base
  belongs_to :election
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :bio, presence: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
