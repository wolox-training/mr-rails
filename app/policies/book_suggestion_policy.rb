class BookSuggestionPolicy < ApplicationPolicy
  def create?
    user.id == record.user_id || user.nil?
  end
end
