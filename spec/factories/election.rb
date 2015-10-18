FactoryGirl.define do
  factory :election do
    sequence(:name) { |n| "Election #{n}" }
    start_at Time.zone.now
    end_at 1.week.from_now
    user
  end
end
