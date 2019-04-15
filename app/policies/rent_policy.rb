class RentPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    user.id == record.user_id
  end
end
