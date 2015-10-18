module V1
  class ElectionResource < BaseResource
    attributes :name, :start_at, :end_at, :owner
  end
end
