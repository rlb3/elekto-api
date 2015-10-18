module V1
  class UserResource < BaseResource
    attributes :name, :email, :password
    has_one :election

    def fetchable_fields
      super - [:password]
    end
  end
end
