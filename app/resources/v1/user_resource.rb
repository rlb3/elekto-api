module V1
  class UserResource < BaseResource
    attributes :name, :email, :password
    has_many :elections

    def fetchable_fields
      super - [:password]
    end
  end
end
